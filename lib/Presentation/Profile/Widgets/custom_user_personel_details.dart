// ignore_for_file: avoid_print

import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Services/profile_firestore_databse.dart';
import 'package:accident/Presentation/login_and_registration/Services/auth_session.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomUserPersonalDetails extends StatefulWidget {
  const CustomUserPersonalDetails({Key? key}) : super(key: key);

  @override
  State<CustomUserPersonalDetails> createState() =>
      _CustomUserPersonalDetailsState();
}

class _CustomUserPersonalDetailsState extends State<CustomUserPersonalDetails> {
  ProfilePageModel? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;
      ProfilePageModel? userData =
          await FireStoreProfileData().getUserData(email);
      setState(() {
        _userData = userData;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch phone dialer.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _userData != null
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Hey I am ${_userData!.name}, living at ${_userData!.address} ${_userData!.emergencyContactName} is my ${_userData!.relation} in case of any emergency contact him/her on this number ${_userData!.emergencyPhone}  ',
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
                              image: AssetImage('assets/images/confetti.png'),
                              fit: BoxFit.contain),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * 0.06),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(_userData!.birthdate.toString())),
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.016,
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
                          await _makePhoneCall(_userData!.emergencyPhone ?? '');
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
                          '${_userData!.emergencyContactName}',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
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
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
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
                          Provider.of<AuthSessionProvider>(context,
                                  listen: false)
                              .logout(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: const DecorationImage(
                                image: AssetImage('assets/images/logout.png'),
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
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        : Center(
            child: Transform.scale(
            scale: 0.1,
            child: LiquidCircularProgressIndicator(
              value: 0.5, // The progress value (0.0 - 1.0)
              valueColor: const AlwaysStoppedAnimation(Colors.yellow),
              backgroundColor: Colors.black,
              borderColor: Colors.yellow,
              borderWidth: 1.0,
              direction: Axis.vertical, // or Axis.horizontal
            ),
          )); // Show a loading indicator while data is being fetched
  }
}
