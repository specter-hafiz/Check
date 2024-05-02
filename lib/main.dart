import 'package:check/firebase_options.dart';
import 'package:check/providers/auth_provider.dart';
import 'package:check/providers/db_provider.dart';
import 'package:check/providers/theme_provider.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: DBProvider()),
        ChangeNotifierProvider.value(value: ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color(0xff0D2CD9),
          appBarTheme: AppBarTheme(backgroundColor: Colors.blue.shade600)),
      home: WelcomeScreen(),
      routes: {
        "/welcome": (context) => WelcomeScreen(),
      },
    );
  }
}
