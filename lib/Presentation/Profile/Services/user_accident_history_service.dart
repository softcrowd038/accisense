// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:accident/Presentation/Profile/Model/user_accident_details.dart';
import 'package:accident/data/common_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserAccidentHistoryService {
  Future<List<UserAccidentHistory>> getUserAccidentHistory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final url = Uri.parse('$apiBaseUrl/accidents');
    final authToken = sharedPreferences.getString('auth_token');

    if (authToken == null) {
      return [];
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
      print('entered');

      if (response.statusCode == 200) {
        print('entered if');
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        return (jsonResponse as List)
            .map((json) =>
                UserAccidentHistory.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        print('Failed to fetch Accident Data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching accident Data: $e');
    }
    return [];
  }
}
