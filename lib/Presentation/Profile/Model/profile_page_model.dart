import 'dart:io';
import 'package:flutter/material.dart';

class ProfilePageModel extends ChangeNotifier {
  String? imageurl;
  String? name;
  String? email;
  String? phone;
  String? emergencyContactName;
  String? relation;
  String? emergencyPhone;
  String? address;
  DateTime? birthdate;
  String? gender;

  ProfilePageModel({
    this.imageurl,
    this.name,
    this.email,
    this.phone,
    this.emergencyContactName,
    this.relation,
    this.emergencyPhone,
    this.address,
    this.birthdate,
    this.gender,
  });

  // Factory method to construct ProfilePageModel from Firestore data
  factory ProfilePageModel.fromMap(Map<String, dynamic> data) {
    return ProfilePageModel(
      imageurl: data['profilePictureUrl'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      emergencyContactName: data['emergencyContactName'],
      relation: data['relation'],
      emergencyPhone: data['emergencyPhone'],
      address: data['address'],
      birthdate: data['birthdate'],
      gender: data['gender'],
    );
  }

  void setImageUrl(File file) {
    imageurl = file.path; // Store the image path
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPhone(String phone) {
    this.phone = phone;
    notifyListeners();
  }

  void setEmergencyContactName(String emergencyContactName) {
    this.emergencyContactName = emergencyContactName;
    notifyListeners();
  }

  void setRelation(String relation) {
    this.relation = relation;
    notifyListeners();
  }

  void setEmergencyPhone(String emergencyPhone) {
    this.emergencyPhone = emergencyPhone;
    notifyListeners();
  }

  void setAddress(String address) {
    // Changed method name to camelCase
    this.address = address;
    notifyListeners();
  }

  void setBirthdate(DateTime birthdate) {
    // Changed method name to camelCase
    this.birthdate = birthdate;
    notifyListeners();
  }

  void setGender(String? gender) {
    this.gender = gender;

    notifyListeners();
  }
}
