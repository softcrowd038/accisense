import 'package:accident/Presentation/Accident_Detection/services/accident_detection_provider.dart';
import 'package:accident/Presentation/GoogleMapIntegration/live_location.dart';
import 'package:accident/Presentation/Profile/Services/user_profile_service.dart';
import 'package:accident/Presentation/dashboard/Utils/altitude_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/navigation_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/speed_provider.dart';
import 'package:accident/Presentation/dashboard/components/accident_confirmation_popup.dart';
import 'package:accident/Presentation/dashboard/components/auto_scroll_icon_carosel.dart';
import 'package:accident/Presentation/dashboard/components/container_reuse.dart';
import 'package:accident/Presentation/dashboard/components/wide_container_with_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isPopupOpen = false;
  AccidentDetectionProvider? _detected;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      UserProfileService userData = UserProfileService();
      final userProfileDetails = await userData.getUserOnlyProfile(context);
      if (userProfileDetails != null) {}
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching user data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _detected ??= context.read<AccidentDetectionProvider>();
    _detected!.addListener(_accidentListener);

    if (_detected!.isAccidentDetected && !_isPopupOpen) {
      Future.delayed(Duration.zero, () {
        _navigateToAccidentPopup();
      });
    }
  }

  void _accidentListener() {
    if (!mounted) return;
    if (_detected!.isAccidentDetected && !_isPopupOpen) {
      _isPopupOpen = true;
      _navigateToAccidentPopup();
    }
  }

  void _navigateToAccidentPopup() {
    if (!mounted) return;
    _isPopupOpen = true;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccidentPopup(
          onTimeout: () {
            _isPopupOpen = false;
            _detected?.resetAccidentDetection();
          },
        ),
      ),
    ).then((_) {
      if (mounted) _isPopupOpen = false;
    });
  }

  @override
  void dispose() {
    _detected?.removeListener(_accidentListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SpeedTrackerNotifier>(
          create: (_) => SpeedTrackerNotifier()..requestLocationPermission(),
        ),
        ChangeNotifierProvider<AltitudeTracker>(
          create: (_) => AltitudeTracker()..requestLocationPermission(),
        ),
        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
      ],
      child: SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.008),
              child: const LiveLocationTracker(),
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.008),
              child: Text(
                'Statistics and Helpline',
                style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).height * 0.022,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.sizeOf(context).height * 0.018,
                          top: MediaQuery.sizeOf(context).height * 0.015,
                        ),
                        child: Consumer<SpeedTrackerNotifier>(
                          builder: (context, speedTracker, child) {
                            return ReuseContainer(
                              color: Colors.white,
                              icon: Icons.speed,
                              height:
                                  MediaQuery.of(context).size.height * 0.060,
                              width: MediaQuery.of(context).size.height * 0.060,
                              size: MediaQuery.of(context).size.height * 0.030,
                              iconColor: Colors.green,
                              value:
                                  '${speedTracker.speed.toStringAsFixed(2)} m/s',
                              title: 'speed',
                            );
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.sizeOf(context).height * 0.018,
                          top: MediaQuery.sizeOf(context).height * 0.015,
                        ),
                        child: Consumer<AltitudeTracker>(
                          builder: (context, altitudeTracker, child) {
                            return ReuseContainer(
                              color: Colors.white,
                              icon: Icons.height,
                              height:
                                  MediaQuery.of(context).size.height * 0.060,
                              width: MediaQuery.of(context).size.height * 0.060,
                              size: MediaQuery.of(context).size.height * 0.030,
                              iconColor: const Color.fromARGB(255, 58, 58, 58),
                              value:
                                  '${altitudeTracker.altitude.toStringAsFixed(2)} m',
                              title: 'altitude',
                            );
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.sizeOf(context).height * 0.018,
                          top: MediaQuery.sizeOf(context).height * 0.015,
                        ),
                        child: ReuseContainer(
                          color: Colors.white,
                          icon: Icons.local_police,
                          height: MediaQuery.of(context).size.height * 0.060,
                          width: MediaQuery.of(context).size.height * 0.060,
                          size: MediaQuery.of(context).size.height * 0.030,
                          iconColor: const Color.fromARGB(255, 255, 230, 0),
                          value: '100',
                          title: 'police',
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.sizeOf(context).height * 0.018,
                          top: MediaQuery.sizeOf(context).height * 0.015,
                        ),
                        child: ReuseContainer(
                          color: Colors.white,
                          icon: Icons.local_hospital,
                          height: MediaQuery.of(context).size.height * 0.060,
                          width: MediaQuery.of(context).size.height * 0.060,
                          size: MediaQuery.of(context).size.height * 0.030,
                          iconColor: const Color.fromARGB(255, 4, 0, 255),
                          value: '102',
                          title: 'ambulance',
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.sizeOf(context).height * 0.018,
                          top: MediaQuery.sizeOf(context).height * 0.015,
                        ),
                        child: ReuseContainer(
                          color: Colors.white,
                          icon: Icons.fire_truck,
                          height: MediaQuery.of(context).size.height * 0.060,
                          width: MediaQuery.of(context).size.height * 0.060,
                          size: MediaQuery.of(context).size.height * 0.030,
                          iconColor: const Color.fromARGB(255, 255, 166, 0),
                          value: '101',
                          title: 'fire-brigade',
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.sizeOf(context).height * 0.018,
                          top: MediaQuery.sizeOf(context).height * 0.015,
                        ),
                        child: ReuseContainer(
                          color: Colors.white,
                          icon: Icons.call_rounded,
                          height: MediaQuery.of(context).size.height * 0.060,
                          width: MediaQuery.of(context).size.height * 0.060,
                          size: MediaQuery.of(context).size.height * 0.030,
                          iconColor: const Color.fromARGB(255, 255, 0, 0),
                          value: '192',
                          title: 'helpline',
                        )),
                  ],
                ),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.008),
              child: const WideContainer(),
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.008),
              child: Text(
                'God\'s Message For you',
                style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).height * 0.022,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).height * 0.008),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.sizeOf(context).height * 0.03,
                    backgroundImage: const NetworkImage(
                      'https://img.freepik.com/free-vector/black-background-with-glowing-light-effect_1017-30649.jpg',
                    ),
                  ),
                  SizedBox(width: MediaQuery.sizeOf(context).height * 0.008),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'god_you_belive_in',
                        style: TextStyle(
                          fontSize: MediaQuery.sizeOf(context).height * 0.018,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'infinity years ago',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.sizeOf(context).height * 0.014,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const AutoCarouselIcon(),
          ],
        ),
      )),
    );
  }
}
