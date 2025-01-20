// ignore_for_file: avoid_print

import 'dart:io';

import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Services/profile_firestore_databse.dart';
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.isEdit) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _retainImage();
      });
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      if (!mounted) return;
      Provider.of<ProfilePageModel>(context, listen: false)
          .setImageUrl(File(pickedImage.path));
    } else {
      if (!mounted) return;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('No image selected')));
      });
    }
  }

  Future<void> _retainImage() async {
    try {
      String? userEmail =
          Provider.of<ProfilePageModel>(context, listen: false).email;

      String? imageUrl =
          await FireStoreProfileData().getImageUrlFromFirestore(userEmail!);

      if (await File(imageUrl!).exists()) {
        if (!mounted) return;
        Provider.of<ProfilePageModel>(context, listen: false)
            .setImageUrl(File(imageUrl));
        return;
      }
      if (!mounted) return;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image not found in Firestore')));
      });
    } catch (e) {
      print('Error retrieving image from Firestore: $e');
      if (!mounted) return;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to retrieve image')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileModel = Provider.of<ProfilePageModel>(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height * 0.06),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 1),
                    spreadRadius: 2,
                    blurRadius: 9,
                    color: Color.fromARGB(255, 214, 214, 214))
              ]),
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.height * 0.06,
            backgroundColor: Colors.white,
            backgroundImage: profileModel.imageurl != null
                ? FileImage(File(profileModel.imageurl!))
                : null,
            child: profileModel.imageurl == null
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
