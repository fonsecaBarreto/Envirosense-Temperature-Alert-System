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

  @override
  void initState() {
    _handleLoopRequest();
  }

  renderCircle(Metrics _metrics) {
    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 4),
        shape: BoxShape.circle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${_metrics.temperature}",
            style: TextStyle(fontSize: 64, color: Colors.white),
          ),
          Text(
            "${_metrics.humidity}",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text("Wallace Ocyan"),
      ),
      body: Center(
        child: ValueListenableBuilder<Metrics?>(
          valueListenable: controller.resultNotifier,
          builder: (context, metrics, child) {
            return Container(
                child: metrics == null
                    ? CircularProgressIndicator()
                    : renderCircle(metrics));
          },
        ),
      ),
    );
  }
}
