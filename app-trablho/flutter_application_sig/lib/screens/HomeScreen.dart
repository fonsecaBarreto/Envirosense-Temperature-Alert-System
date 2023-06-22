import 'dart:async';
import 'package:flutter/material.dart';
import '../controllers/homeController.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = HomeController();
  late Timer timer;

  void _handleLoopRequest() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      controller.makeGetRequest();
    });
  }

  void moveToLogin(context) {
    Navigator.pushNamed(context, '/login');
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
    moveToLogin(context);
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text("Wallace Ocyan"),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return ValueListenableBuilder<List<Metrics>>(
          valueListenable: controller.resultNotifier,
          builder: (context, metrics, child) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                color: metrics.length == 0 || metrics[0].temperature < 30
                    ? Colors.blueAccent
                    : Color.fromARGB(255, 255, 42, 0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        child: metrics.length == 0
                            ? Center(
                                child: Text(
                                "Conectando ao servidor...",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ))
                            : renderCircle(metrics[0])),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
