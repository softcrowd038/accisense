import 'package:accident/Presentation/Navigation/page_navigation.dart';
import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Services/profile_firestore_databse.dart';
import 'package:accident/Presentation/Profile/Widgets/custom_textfield.dart';
import 'package:accident/Presentation/Profile/Widgets/profile_picture.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/custom_button_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileDetails extends StatefulWidget {
  const EditProfileDetails({Key? key}) : super(key: key);

  @override
  State<EditProfileDetails> createState() => _EditProfileDetailsState();
}

class _EditProfileDetailsState extends State<EditProfileDetails> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _guardianController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _emergencyPhoneController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ProfilePageModel? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _guardianController.dispose();
    _relationController.dispose();
    _emergencyPhoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _updateName(String value) {
    _userData?.setName(value);
  }

  void _updateEmail(String value) {
    _userData?.setEmail(value);
  }

  void _updatePhone(String value) {
    _userData?.setPhone(value);
  }

  void _updateEmergencyContactName(String value) {
    _userData?.setEmergencyContactName(value);
  }

  void _updateRelation(String value) {
    _userData?.setRelation(value);
  }

  void _updateEmergencyPhone(String value) {
    _userData?.setEmergencyPhone(value);
  }

  void _updateAddress(String value) {
    _userData?.setAddress(value);
  }

  Future<void> _fetchUserData() async {
    try {
      final String email = FirebaseAuth.instance.currentUser!.email!;
      final userData = await FireStoreProfileData().getUserData(email);
      if (userData != null) {
        setState(() {
          _userData = userData;
          _nameController.text = _userData!.name ?? '';
          _emailController.text = _userData!.email ?? '';
          _phoneController.text = _userData!.phone ?? '';
          _guardianController.text = _userData!.emergencyContactName ?? '';
          _relationController.text = _userData!.relation ?? '';
          _emergencyPhoneController.text = _userData!.emergencyPhone ?? '';
          _addressController.text = _userData!.address ?? '';
        });
      }
    } catch (e) {
      Text('Error fetching user data: $e');
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
                        suffixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        onChanged: (value) {
                          _updateEmail(value);
                        },
                        obscureText: false,
                        hint: "xyz123@pqr.abc",
                        label: "Email",
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your Email first!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        color: Colors.black,
                        suffixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                          size: 30,
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
                        suffixIcon: const Icon(
                          Icons.home,
                          color: Colors.black,
                          size: 30,
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
                        suffixIcon: const Icon(
                          Icons.phone,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        onChanged: (value) {
                          _updateEmergencyContactName(value);
                        },
                        obscureText: false,
                        hint: "eg. Alex Doe",
                        label: "Guardien",
                        controller: _guardianController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the Name first!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        color: Colors.black,
                        suffixIcon: const Icon(
                          Icons.person_2,
                          color: Colors.black,
                          size: 30,
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
                        suffixIcon: const Icon(
                          Icons.group,
                          color: Colors.black,
                          size: 30,
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
                        suffixIcon: const Icon(
                          Icons.phone_android,
                          color: Colors.black,
                          size: 30,
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
                  final profilePageModel =
                      Provider.of<ProfilePageModel>(context, listen: false);
                  FireStoreProfileData().storeUserData(
                      profilePageModel.imageurl,
                      _nameController.text,
                      _emailController.text,
                      _phoneController.text,
                      _guardianController.text,
                      _relationController.text,
                      _emergencyPhoneController.text,
                      _addressController.text,
                      profilePageModel.birthdate,
                      profilePageModel.gender);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
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
