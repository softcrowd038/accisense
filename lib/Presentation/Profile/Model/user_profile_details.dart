import 'dart:convert';

import 'package:accident/Presentation/login_and_registration/Model/user_profile.dart';
import 'package:flutter/material.dart';

class UserProfileDetails extends ChangeNotifier {
  final int? id;
  final String? username;
  final String? email;
  final String? name;
  final String? address;
  final String? mobileNumber;
  final int? age;
  final String? gender;
  final List<String>? allergies;
  final List<String>? medicalHistory;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic? image;
  final List<EmergencyContact>? emergencyContacts;

  UserProfileDetails({
    this.id,
    this.username,
    this.email,
    this.name,
    this.address,
    this.mobileNumber,
    this.age,
    this.gender,
    this.allergies,
    this.medicalHistory,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.emergencyContacts,
  });

  factory UserProfileDetails.fromRawJson(String str) =>
      UserProfileDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfileDetails.fromJson(Map<String, dynamic> json) =>
      UserProfileDetails(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        name: json["name"],
        address: json["address"],
        mobileNumber: json["mobile_number"],
        age: json["age"],
        gender: json["gender"],
        allergies: List<String>.from(json["allergies"].map((x) => x)),
        medicalHistory:
            List<String>.from(json["medical_history"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"],
        emergencyContacts: List<EmergencyContact>.from(
            json["emergency_contacts"]
                .map((x) => EmergencyContact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "name": name,
        "address": address,
        "mobile_number": mobileNumber,
        "age": age,
        "gender": gender,
        "allergies": List<dynamic>.from(allergies!.map((x) => x)),
        "medical_history": List<dynamic>.from(medicalHistory!.map((x) => x)),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "image": image,
        "emergency_contacts":
            List<dynamic>.from(emergencyContacts!.map((x) => x.toJson())),
      };
}
