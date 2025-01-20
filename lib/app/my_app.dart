import 'package:accident/Presentation/Navigation/page_navigation.dart';
import 'package:accident/Presentation/login_and_registration/Services/auth_session.dart';
import 'package:accident/Presentation/splashScreen/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthSessionProvider>(
      create: (_) =>
          AuthSessionProvider(), // Instantiate AuthSessionProvider here
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.blue[300],
            unselectedItemColor: Colors.grey,
          ),
        ),
        home: Consumer<AuthSessionProvider>(
          builder: (context, authProvider, _) {
            switch (authProvider.status) {
              case AuthStatus.authenticated:
                return const HomePage();
              case AuthStatus.unauthenticated:
                return const SplashScreen();
            }
          },
        ),
        // home: const SplashScreen(),
      ),
    );
  }
}
