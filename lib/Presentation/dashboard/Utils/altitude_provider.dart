import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class AltitudeTracker extends ChangeNotifier {
  double _altitude = 0.0;
  StreamSubscription<Position>? _positionStreamSubscription;
  Color _color = Colors.white;
  double get altitude => _altitude;
  Color get color => _color;

  Future<void> requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.locationWhenInUse.request();
    }
    if (status.isGranted) {
      _startTrackingAltitude();
    }
  }

  void _startTrackingAltitude() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    );

    _positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      _updateAltitude(position.altitude);
    });
  }

  void _updateAltitude(double newAltitude) {
    _altitude = newAltitude;
    _color = _determineColor(newAltitude);
    notifyListeners();
  }

  Color _determineColor(double altitude) {
    if (altitude <= 1000) {
      return Colors.white;
    } else {
      return Colors.red;
    }
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }
}
