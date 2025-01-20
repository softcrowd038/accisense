import 'package:accident/Presentation/GoogleMapIntegration/live_location.dart';
import 'package:accident/Presentation/dashboard/Utils/altitude_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/navigation_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/speed_provider.dart';
import 'package:accident/Presentation/dashboard/components/auto_scroll_icon_carosel.dart';
import 'package:accident/Presentation/dashboard/components/container_reuse.dart';
import 'package:accident/Presentation/dashboard/components/seconadary_components/text_widget.dart';
import 'package:accident/Presentation/dashboard/components/wide_container_with_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SpeedTrackerNotifier>(
          create: (_) => SpeedTrackerNotifier(),
        ),
        ChangeNotifierProvider<AltitudeTracker>(
          create: (_) => AltitudeTracker(),
        ),
        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
      ],
      child: SingleChildScrollView(
        child: OrientationBuilder(builder: (context, orientation) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.sizeOf(context).height * 0.018,
                                top: MediaQuery.sizeOf(context).height * 0.015,
                              ),
                              child: Consumer<SpeedTrackerNotifier>(
                                builder: (context, speedTracker, child) {
                                  return ReuseContainer(
                                    color: speedTracker.color,
                                    speed:
                                        '${speedTracker.speed.toStringAsFixed(2)} m/s',
                                    icon: Icons.speed,
                                    height: orientation == Orientation.portrait
                                        ? MediaQuery.of(context).size.height *
                                            0.090
                                        : MediaQuery.of(context).size.height *
                                            0.90,
                                    width: orientation == Orientation.portrait
                                        ? MediaQuery.of(context).size.height *
                                            0.090
                                        : MediaQuery.of(context).size.height *
                                            0.90,
                                    size: 45,
                                    iconColor: Colors.green,
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.sizeOf(context).height * 0.010,
                                top: MediaQuery.sizeOf(context).height * 0.005,
                              ),
                              child: const TextWidget(
                                  text1: "Speed",
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 109, 109, 109),
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.sizeOf(context).height * 0.018,
                            top: MediaQuery.sizeOf(context).height * 0.015,
                          ),
                          child: Consumer<AltitudeTracker>(
                            builder: (context, altitudeTracker, child) {
                              return ReuseContainer(
                                color: altitudeTracker.color,
                                speed:
                                    '${altitudeTracker.altitude.toStringAsFixed(2)} m',
                                icon: Icons.terrain,
                                height:
                                    MediaQuery.of(context).size.height * 0.090,
                                width:
                                    MediaQuery.of(context).size.height * 0.090,
                                size: 45,
                                iconColor:
                                    const Color.fromARGB(255, 255, 230, 0),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.sizeOf(context).height * 0.010,
                            top: MediaQuery.sizeOf(context).height * 0.005,
                          ),
                          child: const TextWidget(
                              text1: "Altitude",
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 109, 109, 109),
                              fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.sizeOf(context).height * 0.005),
                      child: const TextWidget(
                          text1: "Location",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.sizeOf(context).height * 0.005),
                      child: const LiveLocationTracker(),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.sizeOf(context).height * 0.005),
                      child: const TextWidget(
                          text1: "HelpLine",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22),
                    ),
                    const AutoCarouselIcon(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.sizeOf(context).height * 0.005),
                      child: const TextWidget(
                          text1: "Status",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22),
                    ),
                    const WideContainer(),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
