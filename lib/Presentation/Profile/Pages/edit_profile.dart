// ignore_for_file: use_build_context_synchronously

import 'package:accident/Presentation/Profile/Model/user_profile_details.dart';
import 'package:accident/Presentation/Profile/Services/user_profile_service.dart';
import 'package:accident/Presentation/Profile/Widgets/custom_textfield.dart';
import 'package:accident/Presentation/Profile/Widgets/profile_picture.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_profile.dart';
import 'package:accident/Presentation/login_and_registration/Services/user_registration_login.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/custom_button_.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileDetails extends StatefulWidget {
  const EditProfileDetails({Key? key}) : super(key: key);

  @override
  State<EditProfileDetails> createState() => _EditProfileDetailsState();
}

class _EditProfileDetailsState extends State<EditProfileDetails> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _guardianController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _emergencyPhoneController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserProfileDetails? _userData;
  User? _user;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();

    _phoneController.dispose();
    _guardianController.dispose();
    _relationController.dispose();
    _emergencyPhoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _updateName(String value) {
    _user?.setName(value);
  }

  void _updatePhone(String value) {
    _user?.setMobileNumber(value);
  }

  void _updateEmergencyContactName(String newName, int index) {
    if (_user!.emergencyContacts.isNotEmpty &&
        index < _user!.emergencyContacts.length) {
      _user!.emergencyContacts[index].name = newName;
      _user!.setEmergencyContacts([..._user!.emergencyContacts]);
    } else {
      print("Error: Emer_gency contact list is empty or index out of bounds");
    }
  }

  void _updateRelation(String value) {
    _user!.setEmergencyContacts([
      EmergencyContact(
          name: _userData!.emergencyContacts!.first.name,
          relation: value,
          mobile: _userData!.emergencyContacts!.first.mobile)
    ]);
  }

  void _updateEmergencyPhone(String value) {
    _user!.setEmergencyContacts([
      EmergencyContact(
          name: _userData!.emergencyContacts!.first.name,
          relation: _userData!.emergencyContacts!.first.relation,
          mobile: value)
    ]);
  }

  void _updateAddress(String value) {
    _user?.setAddress(value);
  }

  Future<void> _fetchUserData() async {
    try {
      UserProfileService? userData = UserProfileService();
      final userProfileDetails = await userData.getUserProfile();
      if (userProfileDetails != null) {
        setState(() {
          _userData = userProfileDetails;
        });
      }

      setState(() {
        _nameController.text = _userData!.name ?? '';

        _phoneController.text = _userData!.mobileNumber ?? '';
        _guardianController.text = _userData!.emergencyContacts!.first.name;
        _relationController.text = _userData!.emergencyContacts!.first.relation;
        _emergencyPhoneController.text =
            _userData!.emergencyContacts!.first.mobile;
        _addressController.text = _userData!.address ?? '';
      });
    } catch (e) {
      Text('Error fetching user data: $e');
    }
  }

  Future<void> _updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      final user = Provider.of<User>(context, listen: false);
      try {
        final Map<String, dynamic> updatedFields = {
          'name': _nameController.text,
          'address': _addressController.text,
          'mobile_number': _phoneController.text,
          'image': user.image,
          'emergency_contacts': [
            {
              'name': _guardianController.text,
              'relation': _relationController.text,
              'mobile': _emergencyPhoneController.text,
            }
          ],
        };

        UserRegistrationLogin userRegistrationLogin = UserRegistrationLogin();

        final updatedUser =
            await userRegistrationLogin.updateUser(context, updatedFields);

        if (updatedUser != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to update profile. Please try again.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: ProfilePictureField(isEdit: true),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        onChanged: (value) {
                          _updateName(value);
                        },
                        obscureText: false,
                        hint: "eg. John Doe",
                        label: "Name",
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your Name first!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        color: Colors.black,
                        suffixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        onChanged: (value) {
                          _updateAddress(value);
                        },
                        obscureText: false,
                        hint:
                            "John Doe123, Main Street,Gandhi Nagar,Bangalore,Karnataka - 560001,India",
                        label: "Adress",
                        controller: _addressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your Emergency Phone first!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        color: Colors.black,
                        suffixIcon: Icon(
                          Icons.home,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        onChanged: (value) {
                          _updatePhone(value);
                        },
                        obscureText: false,
                        hint: "+91 1234567890",
                        label: "Phone",
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your Phone first!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        color: Colors.black,
                        suffixIcon: Icon(
                          Icons.phone,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        onChanged: (value) {
                          _updateEmergencyContactName(value, 1);
                        },
                        obscureText: false,
                        hint: "eg. Alex Doe",
                        label: "Emergency Contact name",
                        controller: _guardianController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the Name first!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        color: Colors.black,
                        suffixIcon: Icon(
                          Icons.person_2,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        onChanged: (value) {
                          _updateRelation(value);
                        },
                        obscureText: false,
                        hint: "eg. father",
                        label: "Relation",
                        controller: _relationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your Relation first!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        color: Colors.black,
                        suffixIcon: Icon(
                          Icons.group,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        onChanged: (value) {
                          _updateEmergencyPhone(value);
                        },
                        obscureText: false,
                        hint: "+91 1234567890",
                        label: "Emergency Phone",
                        controller: _emergencyPhoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your Emergency Phone first!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        color: Colors.black,
                        suffixIcon: Icon(
                          Icons.phone_android,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _updateUserProfile();
                }
              },
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.008),
                child: const CustomButton(
                  buttonText: "Update",
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
