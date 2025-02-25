// ignore_for_file: avoid_print

import 'package:accident/Presentation/Profile/Model/user_profile_details.dart';
import 'package:accident/Presentation/login_and_registration/pages/login_registration.dart';
import 'package:accident/data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileService {
  Future<UserProfileDetails?> getUserProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final url = Uri.parse('$apiBaseUrl/profile');
    final authToken = sharedPreferences.getString('auth_token');

    if (authToken == null) {
      return null;
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        return UserProfileDetails.fromRawJson(response.body);
      } else {
        print('Failed to fetch user profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
    return null;
  }

  Future<UserProfileDetails?> getUserOnlyProfile(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final url = Uri.parse('$apiBaseUrl/profile');
    final authToken = sharedPreferences.getString('auth_token');

    if (authToken == null) {
      showSnackBar(context, 'Authentication token is missing.');
      return null;
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        return UserProfileDetails.fromRawJson(response.body);
      } else if (response.statusCode == 401 || response.statusCode == 404 ) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        bool logoutStatus = await sharedPreferences.remove('auth_token');
        if (logoutStatus == true) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      } else {
        showSnackBar(
            context, 'Failed to fetch user profile: ${response.statusCode}');
      }
    } catch (e) {
      showSnackBar(context, 'Error fetching user profile: $e');
    }
    return null;
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
