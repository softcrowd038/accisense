// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ReverseTimerPage extends StatefulWidget {
  const ReverseTimerPage({super.key});

  @override
  _ReverseTimerPageState createState() => _ReverseTimerPageState();
}

class _ReverseTimerPageState extends State<ReverseTimerPage> {
  int _remainingTime = 30;
  bool isNotificationCancelled = false;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
        setState(() {
          isNotificationCancelled = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _remainingTime / 30;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reverse Timer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 150.0,
              lineWidth: 10.0,
              animation: true,
              percent: progress,
              center: Text(
                '$_remainingTime',
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              progressColor: Colors.blue,
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),
            Text(
              isNotificationCancelled
                  ? "Notification Cancelled"
                  : "Timer Running",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
