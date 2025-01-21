import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class SpeedTrackerNotifier extends ChangeNotifier {
  double _speed = 0.0;
  Color _color = Colors.green;
  StreamSubscription<Position>? _positionStreamSubscription;

  double get speed => _speed;
  Color get color => _color;

  Future<void> requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.locationWhenInUse.request();
    }
    if (status.isGranted) {
      _startTrackingSpeed();
    }
  }

  void _startTrackingSpeed() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    );

    _positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      _updateSpeed(position.speed);
      notifyListeners();
    });
  }

  void _updateSpeed(double newSpeed) {
    _speed = newSpeed;
    if (_speed <= 70.0) {
      _color = Colors.green;
    } else {
      _color = Colors.red;
    }
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }
}
