// ignore_for_file: avoid_print

import 'package:accident/Presentation/Profile/Model/user_profile_details.dart';
import 'package:accident/data/common_data.dart';
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
}
