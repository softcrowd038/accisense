// main.dart
// ignore_for_file: avoid_print

import 'package:accident/Presentation/Accident_Detection/services/accident_detection_provider.dart';
import 'package:accident/Presentation/Profile/Model/health_details_page.dart';
import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Model/user_accident_details.dart';
import 'package:accident/Presentation/Profile/Model/user_profile_details.dart';
import 'package:accident/Presentation/dashboard/Utils/accelerometer_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/altitude_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/gyroscope_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/location_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/navigation_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/speed_provider.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_profile.dart';
import 'package:accident/app/my_app.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    print("task is working in background");
    return Future.value(true);
  });
}

Future<void> requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.sms,
    Permission.contacts
  ].request();

  if (statuses[Permission.location]?.isDenied ?? true) {
    print("Location permission denied.");
  }

  if (statuses[Permission.sms]?.isDenied ?? true) {
    print("SMS permission denied.");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestPermissions();

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: "accident_channel",
        channelName: "Detection Notification",
        channelDescription: "Notification Channel for basic test",
      ),
    ],
    debug: true,
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  Workmanager().initialize(callbackDispatcher);

  runApp(const MyAppProviders());
}

class MyAppProviders extends StatelessWidget {
  const MyAppProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Workmanager().registerPeriodicTask(
      "1",
      "simplePeriodicTask",
      frequency: const Duration(seconds: 5),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfilePageModel>(
          create: (_) => ProfilePageModel(),
        ),
        ChangeNotifierProvider<UserProfileDetails>(
          create: (_) => UserProfileDetails(),
        ),
        ChangeNotifierProvider<User>(
          create: (_) => User(),
        ),
        ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider()),
        ChangeNotifierProvider<UserCredentials>(
          create: (_) => UserCredentials(),
        ),
        ChangeNotifierProvider<UserAccidentHistory>(
          create: (_) => UserAccidentHistory(),
        ),
        ChangeNotifierProvider<HealthDetailsModel>(
            create: (_) => HealthDetailsModel()),
        ChangeNotifierProvider<SpeedTrackerNotifier>(
            create: (_) => SpeedTrackerNotifier()),
        ChangeNotifierProvider<AltitudeTracker>(
            create: (_) => AltitudeTracker()),
        ChangeNotifierProvider<NavigationProvider>(
            create: (_) => NavigationProvider()),
        ChangeNotifierProvider<GyroscopeProvider>(
            create: (_) => GyroscopeProvider()),
        ChangeNotifierProvider<AccelerometerProvider>(
            create: (_) => AccelerometerProvider()),
        ChangeNotifierProvider<AccidentDetectionProvider>(
          create: (context) => AccidentDetectionProvider(
            locationProvider:
                Provider.of<LocationProvider>(context, listen: false),
            speedProvider:
                Provider.of<SpeedTrackerNotifier>(context, listen: false),
            altitudeProvider:
                Provider.of<AltitudeTracker>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Your App Title',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const MyApp(),
      ),
    );
  }
}
