import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerProvider extends ChangeNotifier {
  bool _isMonitoring = false;
  List<double> _accelerometerValues = [0.0, 0.0, 0.0];
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  bool get isMonitoring => _isMonitoring;
  List<double> get accelerometerValues => _accelerometerValues;

  void startMonitoring() {
    _isMonitoring = true;
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      _accelerometerValues = [event.x, event.y, event.z];
      // Add your accident detection logic here
      notifyListeners();
    });
    notifyListeners();
  }

  void stopMonitoring() {
    _isMonitoring = false;
    _accelerometerSubscription?.cancel(); // Cancel subscription on dispose
    notifyListeners();
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel(); // Cancel subscription on dispose
    super.dispose();
  }
}
