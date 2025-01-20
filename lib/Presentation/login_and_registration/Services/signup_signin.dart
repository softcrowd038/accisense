// ignore_for_file: avoid_print, unused_local_variable
import 'package:accident/Presentation/Navigation/page_navigation.dart';
import 'package:accident/Presentation/Profile/Pages/profile_details.dart';
import 'package:accident/Presentation/login_and_registration/pages/login_registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UiHelper {
  final BuildContext context;

  UiHelper(this.context);

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      Text('Failed with error code: ${e.code}');
      Text(e.message!);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(String email, String password) async {
    bool hasProfileData = await checkProfileDataExistence(email);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null && hasProfileData) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const ProfileDetails()),
        );
      }
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkProfileDataExistence(String email) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    return snapshot.exists;
  }
}

// Inside your login page widget
