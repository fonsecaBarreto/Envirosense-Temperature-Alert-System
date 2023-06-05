import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'controllers/homeController.dart';
import 'package:cron/cron.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = HomeController();
  late Timer timer;

  void _handleLoopRequest() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      controller.makeGetRequest();
    });
  }

  double _getTemperarure(RequestLoadSuccess requestState) {
    double temperature = double.parse(requestState.body['temperature']);
    return temperature;
  }

  double _getHumidity(RequestLoadSuccess requestState) {
    double temperature = double.parse(requestState.body['humidity']);
    return temperature;
  }

  @override
  void initState() {
    _handleLoopRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ValueListenableBuilder<RequestState>(
            valueListenable: controller.resultNotifier,
            builder: (context, requestState, child) {
              if (requestState is RequestLoadInProgress) {
                return CircularProgressIndicator();
              } else if (requestState is RequestLoadSuccess) {
                return Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: [
                    Text(_getTemperarure(requestState).toString()),
                    Text(_getHumidity(requestState).toString())
                  ],
                )));
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
