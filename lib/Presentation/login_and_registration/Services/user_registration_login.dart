// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:accident/Presentation/Navigation/page_navigation.dart';
import 'package:accident/Presentation/login_and_registration/pages/login_registration.dart';
import 'package:accident/data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:accident/Presentation/login_and_registration/Model/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegistrationLogin {
  Future<User?> registerUser(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final url = Uri.parse('$apiBaseUrl/register');

    try {
      var request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Accept': 'application/json',
      });

      request.fields['username'] = user.username;
      request.fields['email'] = user.email;
      request.fields['password'] = user.password;
      request.fields['password_confirmation'] = user.passwordConfirmation;
      request.fields['name'] = user.name;
      request.fields['address'] = user.address;
      request.fields['mobile_number'] = user.mobileNumber;
      request.fields['age'] = user.age.toString();
      request.fields['gender'] = user.gender;
      for (var i = 0; i < user.allergies.length; i++) {
        request.fields['allergies[$i]'] = user.allergies[i];
      }

      for (var i = 0; i < user.medicalHistory.length; i++) {
        request.fields['medical_history[$i]'] = user.medicalHistory[i];
      }

      for (var i = 0; i < user.emergencyContacts.length; i++) {
        request.fields['emergency_contacts[$i][name]'] =
            user.emergencyContacts[i].name;
        request.fields['emergency_contacts[$i][relation]'] =
            user.emergencyContacts[i].relation;
        request.fields['emergency_contacts[$i][mobile]'] =
            user.emergencyContacts[i].mobile;
      }
      if (user.image != null && user.image!.path.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('image', user.image!.path),
        );
      }

      print("Sending Request: ${request.fields}");

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: $responseBody");

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(responseBody);
        final registeredUser = User();
        registeredUser.setUsername(jsonResponse['username'] ?? '');
        registeredUser.setEmail(jsonResponse['email'] ?? '');
        registeredUser.setName(jsonResponse['name'] ?? '');
        registeredUser.setAddress(jsonResponse['address'] ?? '');
        registeredUser.setMobileNumber(jsonResponse['mobile_number'] ?? '');
        registeredUser.setAge(jsonResponse['age'] ?? 0);
        registeredUser.setGender(jsonResponse['gender'] ?? '');

        if (jsonResponse['image'] != null && jsonResponse['image'].isNotEmpty) {
          registeredUser.setImage(File(jsonResponse['image']));
        } else {
          registeredUser.setImage(File(''));
        }

        registeredUser
            .setAllergies(List<String>.from(jsonResponse['allergies'] ?? []));
        registeredUser.setMedicalHistory(
            List<String>.from(jsonResponse['medical_history'] ?? []));
        registeredUser.setemergencyContacts(
          (jsonResponse['emergency_contacts'] ?? [])
              .map<EmergencyContact>(
                (contactJson) => EmergencyContact.fromJson(contactJson),
              )
              .toList(),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );

        return registeredUser;
      } else {
        final error = json.decode(responseBody);
        print('Failed to register user. Error: $error');
        throw Exception("Failed to register user. Error: $error");
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception("Error: $e");
    }
  }

  Future<User?> loginUser(
      BuildContext context, String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final url = Uri.parse('$apiBaseUrl/login');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final Map<String, dynamic> body = {
        'email': email,
        'password': password,
      };

      print("Sending Data: ${jsonEncode(body)}");

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print('User Login successfully');

        final jsonResponse = json.decode(response.body);
        final loginUser = User();

        loginUser.setEmail(jsonResponse['email'] ?? '');
        sharedPreferences.setString('auth_token', jsonResponse['token']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );

        return loginUser;
      } else {
        final error = json.decode(response.body);
        print('Failed to Login user. Error: $error');
        throw Exception("Failed to Login user. Error: $error");
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception("Error: $e");
    }
  }

  Future<User?> updateUser(
      BuildContext context, Map<String, dynamic> updatedFields) async {
    final user = Provider.of<User>(context, listen: false);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final authToken = sharedPreferences.getString('auth_token');
    final url = Uri.parse('$apiBaseUrl/update-profile');

    try {
      final request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer $authToken';
      request.headers['Accept'] = 'application/json';

      // updatedFields.forEach((key, value) {
      //   if (value is List) {
      //     request.fields[key] = jsonEncode(value);
      //   } else {
      //     request.fields[key] = value.toString();
      //   }
      // });

      if (user.image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', user.image!.path),
        );
      }

      print("Sending Data: ${updatedFields.toString()}");

      final response = await request.send();

      final responseData = await response.stream.bytesToString();
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: $responseData");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('User updated successfully');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));

        final jsonResponse = json.decode(responseData);

        if (jsonResponse['username'] != null) {
          user.setUsername(jsonResponse['username']);
        }
        if (jsonResponse['email'] != null) {
          user.setEmail(jsonResponse['email']);
        }
        if (jsonResponse['name'] != null) {
          user.setName(jsonResponse['name']);
        }
        if (jsonResponse['address'] != null) {
          user.setAddress(jsonResponse['address']);
        }
        if (jsonResponse['mobile_number'] != null) {
          user.setMobileNumber(jsonResponse['mobile_number']);
        }
        if (jsonResponse['age'] != null) {
          user.setAge(jsonResponse['age']);
        }
        if (jsonResponse['gender'] != null) {
          user.setGender(jsonResponse['gender']);
        }
        if (jsonResponse['image'] != null && jsonResponse['image'].isNotEmpty) {
          user.setImage(File(jsonResponse['image']));
        }
        if (jsonResponse['allergies'] != null) {
          user.setAllergies(
              List<String>.from(jsonResponse['allergies']).toList());
        }
        if (jsonResponse['medical_history'] != null) {
          user.setMedicalHistory(
              List<String>.from(jsonResponse['medical_history']).toList());
        }
        if (jsonResponse['emergency_contacts'] != null) {
          user.setemergencyContacts(
            (jsonResponse['emergency_contacts'] ?? []).map<EmergencyContact>(
              (contactJson) => EmergencyContact.fromJson(contactJson),
            ),
          );
        }
        print(user);

        return user;
      } else {
        final error = json.decode(responseData);
        print('Failed to update user. Error: $error');
        throw Exception("Failed to update user. Error: $error");
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception("Error: $e");
    }
  }
}
