import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/homeController.dart';
import '../repositories/global_repository.dart';

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
    final globalRepository = Provider.of<GlobalRepository>(context);

    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text(
          "Sensor SIG",
        ),
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
                  const SizedBox(height: 32.0),
                  Text(
                    globalRepository.user != null
                        ? "Bem vindo, " + globalRepository.user.toString() + "!"
                        : "Bem vindo",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                        child: metrics.length == 0
                            ? Center(
                                child: Text(
                                "Baixando dados...",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ))
                            : renderCircle(metrics[0])),
                  ),
                  const SizedBox(height: 32.0),
                  const Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      "Sensor de temperatura embarcado alertar os responsaveis caso a temperatura ambiente esteja acima do esperado (30°C).",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  const Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      "Desenvolvido por:\n Lucas Fonseca, Eduarda Sodré e Gabriel Bertusi",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
