// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeProvider extends ChangeNotifier {
  bool _isMonitoring = false;
  List<double> _gyroscopeValues = [0.0, 0.0, 0.0];
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  bool get isMonitoring => _isMonitoring;
  List<double> get gyroscopeValues => _gyroscopeValues;

  void startMonitoring() {
    _isMonitoring = true;
    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      _gyroscopeValues = [event.x, event.y, event.z];
      notifyListeners();
    });
    notifyListeners();
  }

  void stopMonitoring() {
    _isMonitoring = false;
    _gyroscopeSubscription?.cancel(); // Cancel subscription on dispose
    notifyListeners();
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel(); // Cancel subscription on dispose
    super.dispose();
  }
}
