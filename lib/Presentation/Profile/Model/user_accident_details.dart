import 'dart:convert';

import 'package:flutter/material.dart';

class UserAccidentHistory extends ChangeNotifier{
  final int? id;
  final int? userId;
  final String? name;
  final int? age;
  final String? address;
  final String? mobileNumber;
  final String? latitude;
  final String? longitude;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? hospitalId;
  final int? policeStationId;
  final String? statusp;

  UserAccidentHistory({
    this.id,
    this.userId,
    this.name,
    this.age,
    this.address,
    this.mobileNumber,
    this.latitude,
    this.longitude,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.hospitalId,
    this.policeStationId,
    this.statusp,
  });

  factory UserAccidentHistory.fromRawJson(String str) =>
      UserAccidentHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserAccidentHistory.fromJson(Map<String, dynamic> json) =>
      UserAccidentHistory(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        age: json["age"],
        address: json["address"],
        mobileNumber: json["mobile_number"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        hospitalId: json["hospital_id"],
        policeStationId: json["police_station_id"],
        statusp: json["statusp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "age": age,
        "address": address,
        "mobile_number": mobileNumber,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "hospital_id": hospitalId,
        "police_station_id": policeStationId,
        "statusp": statusp,
      };
}
