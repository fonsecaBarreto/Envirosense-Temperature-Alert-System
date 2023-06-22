import 'package:flutter/material.dart';
import 'package:flutter_application_sig/repositories/global_repository.dart';
import 'package:flutter_application_sig/screens/LoadingScreen.dart';
import 'package:flutter_application_sig/screens/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'screens/HomeScreen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => GlobalRepository()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<GlobalRepository>(context);

    return FutureBuilder(
        future: repository.initialLoad(context),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.connectionState == ConnectionState.done) {
            print(repository.user);
            return MaterialApp(
                title: 'SIG',
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepOrange),
                ),
                home: repository.user != null ? MyHomePage() : LoginPage());
          }
          return const Text("Algo está errado.");
        });
  }
}
