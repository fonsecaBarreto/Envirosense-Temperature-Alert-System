import 'package:flutter/material.dart';
import 'package:flutter_application_sig/screens/LoginScreen.dart';
import 'screens/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SIG',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/login': (context) => LoginPage(),
        });
  }
}
