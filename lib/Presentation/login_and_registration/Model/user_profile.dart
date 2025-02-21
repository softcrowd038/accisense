// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String _username = '';
  String _email = '';
  String _password = '';
  String _passwordConfirmation = '';
  String _name = '';
  String _address = '';
  String _mobileNumber = '';
  int _age = 0;
  String _gender = '';
  File? _image;
  List<String> _allergies = [];
  List<String> _medicalHistory = [];
  List<EmergencyContact> _emergencyContacts = [];

  // Getters
  String get username => _username;
  String get email => _email;
  String get password => _password;
  String get passwordConfirmation => _passwordConfirmation;
  String get name => _name;
  String get address => _address;
  String get mobileNumber => _mobileNumber;
  int get age => _age;
  String get gender => _gender;
  File? get image => _image;
  List<String> get allergies => _allergies;
  List<String> get medicalHistory => _medicalHistory;
  List<EmergencyContact> get emergencyContacts => _emergencyContacts;

  // Setters
  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setPasswordConfirmation(String value) {
    _passwordConfirmation = value;
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setAddress(String value) {
    _address = value;
    notifyListeners();
  }

  void setMobileNumber(String value) {
    _mobileNumber = value;
    notifyListeners();
  }

  void setAge(int value) {
    _age = value;
    notifyListeners();
  }

  void setGender(String value) {
    _gender = value;
    notifyListeners();
  }

  void setImage(File value) {
    _image = value;
    notifyListeners();
  }

  void setAllergies(List<String> value) {
    _allergies = value;
    notifyListeners();
  }

  void setMedicalHistory(List<String> value) {
    _medicalHistory = value;
    notifyListeners();
  }

  void setemergencyContacts(List<EmergencyContact> value) {
    _emergencyContacts = value;
    notifyListeners();
  }
}

class EmergencyContact {
  String _name;
  String _relation;
  String _mobile;

  EmergencyContact({
    required String name,
    required String relation,
    required String mobile,
  })  : _name = name,
        _relation = relation,
        _mobile = mobile;

  // Getters
  String get name => _name;
  String get relation => _relation;
  String get mobile => _mobile;

  // Setters
  set name(String value) {
    _name = value;
  }

  set relation(String value) {
    _relation = value;
  }

  set mobile(String value) {
    _mobile = value;
  }

  // Factory methods for JSON serialization
  factory EmergencyContact.fromRawJson(String str) =>
      EmergencyContact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      EmergencyContact(
        name: json["name"],
        relation: json["relation"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "relation": relation,
        "mobile": mobile,
      };
}
