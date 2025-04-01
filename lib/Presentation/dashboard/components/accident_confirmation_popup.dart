// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:accident/Presentation/Accident_Detection/services/accident_detection_provider.dart';
import 'package:accident/Presentation/Navigation/page_navigation.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccidentPopup extends StatefulWidget {
  final VoidCallback onTimeout;

  const AccidentPopup({super.key, required this.onTimeout});

  @override
  State<AccidentPopup> createState() => _AccidentPopupState();
}

class _AccidentPopupState extends State<AccidentPopup> {
  int _counter = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter == 0) {
        timer.cancel();
        widget.onTimeout();
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
        }
      } else {
        setState(() {
          _counter--;
        });
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 253, 228, 1)),
        title: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: const AssetImage("assets/images/logo1.png"),
                    height: MediaQuery.of(context).size.height * 0.10,
                    width: MediaQuery.of(context).size.height * 0.10,
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.035,
              left: MediaQuery.of(context).size.width * 0.17,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Accidetect",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Center(
              child: Consumer<AccidentDetectionProvider>(
                  builder: (context, value, _) =>
                      Column(mainAxisSize: MainAxisSize.min, children: [
                        const Text(
                          "Are you safe?",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Auto-confirming in:",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xff020053).withOpacity(0.2),
                          ),
                          child: Text(
                            "$_counter",
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff020053),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            AwesomeNotifications
                                flutterLocalNotificationsPlugin =
                                AwesomeNotifications();
                            _timer?.cancel();
                            flutterLocalNotificationsPlugin.cancel(10);
                            value.notificationCancelled = true;

                            if (mounted) {
                              Navigator.of(context).pop();
                              context
                                  .read<AccidentDetectionProvider>()
                                  .resetPopupState();
                            }
                          },
                          child: const Text("I'm Safe"),
                        )
                      ]))),
        ],
      ),
    );
  }
}
