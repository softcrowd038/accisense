// ignore_for_file: avoid_print

import 'dart:io';
import 'package:accident/Presentation/Profile/Model/user_profile_details.dart';
import 'package:accident/Presentation/Profile/Services/user_profile_service.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePictureField extends StatefulWidget {
  final bool isEdit;

  const ProfilePictureField({Key? key, required this.isEdit}) : super(key: key);

  @override
  ProfilePictureFieldState createState() => ProfilePictureFieldState();
}

class ProfilePictureFieldState extends State<ProfilePictureField> {
  UserProfileDetails? _userData;
  File? _selectedImage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.isEdit) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _retainImage();
      });
    }
  }

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
      _showSnackbar('Error fetching user data: $e');
    }
  }

  Future<void> _getImage() async {
    print('entered get image');
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        if (!mounted) return;
        setState(() {
          print('entered setstate');
          _selectedImage = File(pickedImage.path);
        });
        Provider.of<User>(context, listen: false).setImage(_selectedImage!);
        print(_selectedImage);
      } else {
        _showSnackbar('No image selected');
      }
    } catch (e) {
      _showSnackbar('Error selecting image: $e');
    }
  }

  Future<void> _retainImage() async {
    if (_userData == null || _userData!.image == null || widget.isEdit) return;
    try {
      String? imageUrl = _userData?.image;
      if (imageUrl != null && imageUrl.isNotEmpty) {
        if (!mounted) return;
        setState(() {
          _selectedImage = File(imageUrl);
        });
        print(_selectedImage);
        Provider.of<User>(context, listen: false).setImage(_selectedImage!);
      } else {
        _showSnackbar('Image not found in Firestore');
      }
    } catch (e) {
      _showSnackbar('Failed to retrieve image');
    }
  }

  void _showSnackbar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.height * 0.06,
            ),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 1),
                spreadRadius: 2,
                blurRadius: 9,
                color: Color.fromARGB(255, 214, 214, 214),
              )
            ],
          ),
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.height * 0.06,
            backgroundColor: Colors.white,
            backgroundImage: _selectedImage != null
                ? FileImage(_selectedImage!)
                : (_userData?.image != null
                    ? NetworkImage('${_userData!.image}') as ImageProvider
                    : null),
            child: (_selectedImage == null && _userData?.image == null)
                ? Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.height * 0.06,
                    color: const Color(0xff020053),
                  )
                : null,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _getImage,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
