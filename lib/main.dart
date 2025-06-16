import 'package:flutter/material.dart';
import 'package:flutter_persistence_donnees/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();
  final garderSession = prefs.getBool('rememberMe') ?? false;

  runApp(MyApp(garderSession: garderSession));
}

class MyApp extends StatelessWidget {
  final bool garderSession;
  const MyApp({super.key, required this.garderSession});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PersData',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: garderSession ? HomePage() : LoginPage(),
      //home: LoginPage(),
    );
  }
}
