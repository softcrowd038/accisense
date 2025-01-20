import 'dart:async';
import 'package:accident/Presentation/Navigation/page_navigation.dart';
import 'package:accident/Presentation/login_and_registration/pages/login_registration.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff020053),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage("assets/images/logo.jpeg"),
                height: MediaQuery.of(context).size.height * 0.250,
                width: MediaQuery.of(context).size.height * 0.250,
              ),
            ]),
      ),
    );
  }
}
