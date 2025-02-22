// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:accident/Presentation/Profile/Model/user_profile_details.dart';
import 'package:accident/Presentation/Profile/Services/user_profile_service.dart';
import 'package:accident/Presentation/login_and_registration/pages/login_registration.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomUserPersonalDetails extends StatefulWidget {
  const CustomUserPersonalDetails({Key? key}) : super(key: key);

  @override
  State<CustomUserPersonalDetails> createState() =>
      _CustomUserPersonalDetailsState();
}

class _CustomUserPersonalDetailsState extends State<CustomUserPersonalDetails> {
  UserProfileDetails? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      UserProfileService userData = UserProfileService();
      final userProfileDetails = await userData.getUserProfile();
      if (userProfileDetails != null) {
        setState(() {
          _userData = userProfileDetails;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool logoutStatus = await sharedPreferences.remove('auth_token');
    if (logoutStatus == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch phone dialer.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _userData != null &&
            _userData!.emergencyContacts != null &&
            _userData!.emergencyContacts!.isNotEmpty
        ? Column(
            children: _userData!.emergencyContacts!.map((contact) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Hey, I am ${_userData!.name}, living at ${_userData!.address}. ${contact.name} is my ${contact.relation}. In case of emergency, contact them at ${contact.mobile}.',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: const DecorationImage(
                                  image:
                                      AssetImage('assets/images/confetti.png'),
                                  fit: BoxFit.contain),
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.06),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _userData!.age.toString(),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.016,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await _makePhoneCall(contact.mobile);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: const DecorationImage(
                                    image: AssetImage('assets/images/call.jpg'),
                                    fit: BoxFit.contain),
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.06),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Call ${contact.name}',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/gender.png'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.06),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _userData!.gender ?? '',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _logout();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: const DecorationImage(
                                    image:
                                        AssetImage('assets/images/logout.png'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.06),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'logout',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.medical_information,
                          size: 24,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Medical History: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _userData!.medicalHistory!.isNotEmpty
                                ? _userData!.medicalHistory!.join(', ')
                                : 'No medical history available.',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.vaccines,
                          size: 24,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Allergies: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _userData!.allergies!.isNotEmpty
                                ? _userData!.allergies!.join(', ')
                                : 'No medical history available.',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          )
        : Center(
            child: Transform.scale(
            scale: 0.1,
            child: LiquidCircularProgressIndicator(
              value: 0.5,
              valueColor: const AlwaysStoppedAnimation(Colors.yellow),
              backgroundColor: Colors.black,
              borderColor: Colors.yellow,
              borderWidth: 1.0,
              direction: Axis.vertical,
            ),
          ));
  }
}
