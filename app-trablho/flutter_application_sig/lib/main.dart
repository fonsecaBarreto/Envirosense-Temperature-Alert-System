import 'dart:async';
import 'package:flutter/material.dart';
import 'controllers/homeController.dart';

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
    controller.loadBeep();
    _handleLoopRequest();
  }

  renderCircle(Metrics _metrics) {
    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 4),
          shape: BoxShape.circle),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${_metrics.temperature.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 64, color: Colors.white),
          ),
          Text(
            "${_metrics.humidity.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text("Wallace Ocyan"),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return ValueListenableBuilder<Metrics?>(
          valueListenable: controller.resultNotifier,
          builder: (context, metrics, child) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                color: metrics == null || metrics.temperature < 30
                    ? Colors.blueAccent
                    : Color.fromARGB(255, 255, 42, 0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        child: metrics == null
                            ? Center(
                                child: Text(
                                "Conectando ao servidor...",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ))
                            : renderCircle(metrics)),
                  ),
                  /* Slider(
                    min: 0.0,
                    max: 60.0,
                    value: metrics?.temperature ?? 0,
                    onChanged: (value) {
                      controller.mockMetrics(value);
                    },
                    onChangeEnd: (value) {
                      controller.handleTemperature(value);
                    },
                  ) */
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
