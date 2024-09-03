import 'package:check/components/shared_preferences.dart';
import 'package:check/firebase_options.dart';
import 'package:check/providers/auth_provider.dart';
import 'package:check/providers/db_provider.dart';
import 'package:check/providers/user_provider.dart';
import 'package:check/screens/admin_home_screen.dart';
import 'package:check/screens/intro_screen.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefs.init(); // Initialize SharedPrefs
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthenticationProvider()),
        ChangeNotifierProvider.value(value: DBProvider()),
        ChangeNotifierProvider.value(value: UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = SharedPrefs.instance;
    final shownBefore = prefs.getBool("shownbefore") ?? false;
    final loggedIn = prefs.getBool("login") ?? false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color(0xff0D2CD9),
          appBarTheme: AppBarTheme(backgroundColor: Colors.blue.shade600)),
      home: _determineHomeScreen(shownBefore, loggedIn),
      routes: {
        "/welcome": (context) => WelcomeScreen(),
      },
    );
  }

  // Determine which screen to show based on shared preferences
  Widget _determineHomeScreen(bool shownBefore, bool loggedIn) {
    if (shownBefore && loggedIn) {
      return AdminHomeScreen();
    } else if (shownBefore && !loggedIn) {
      return WelcomeScreen();
    } else {
      return IntroScreen();
    }
  }
}
