import 'dart:io';
import 'package:accident/Presentation/Accident_Detection/Pages/get_data.dart';
import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Pages/edit_profile.dart';
import 'package:accident/Presentation/Profile/Services/profile_firestore_databse.dart';
import 'package:accident/Presentation/Profile/Widgets/custom_user_personel_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
      if (userData != null) {
        setState(() {
          _userData = userData;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _userData == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff020053),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_userData != null)
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.13,
                            width: MediaQuery.of(context).size.height * 0.13,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff020053), width: 2),
                              borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.height * 0.065,
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.065,
                                ),
                              ),
                              child: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height * 0.06,
                                backgroundImage:
                                    FileImage(File(_userData!.imageurl ?? '')),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileDetails(),
                                  ),
                                );
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                width:
                                    MediaQuery.of(context).size.height * 0.04,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  color: const Color(0xff020053),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  if (_userData != null)
                    Center(
                      child: Text(
                        _userData!.name ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  if (_userData != null)
                    Center(
                      child: Text(
                        '+91 ${_userData!.phone}' ?? '',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.0160,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff020053),
                        ),
                      ),
                    ),
                  if (_userData != null)
                    Center(
                      child: Text(
                        '${_userData!.email}' ?? '',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.0160,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  const CustomUserPersonalDetails(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.012),
                    child: Text(
                      'Accident History',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.0240,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const AccidentListWidget()
                ],
              ),
            ),
    );
  }
}
