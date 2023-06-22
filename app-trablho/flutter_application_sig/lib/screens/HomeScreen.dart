import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/homeController.dart';
import '../repositories/global_repository.dart';

const PRIMARY_COLOR = Color.fromARGB(255, 3, 27, 69);
const SECONDARY_COLOR = Color.fromARGB(255, 4, 17, 41);

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
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage((_metrics.temperature < 31)
                ? "assets/images/pulse2.gif"
                : "assets/images/pulse6.gif"),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            opacity: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 260,
          height: 260,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 5),
            shape: BoxShape.circle,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${_metrics.temperature.toStringAsFixed(1)}°C",
                style: TextStyle(fontSize: 56, color: Colors.white),
              ),
              Text(
                "${_metrics.humidity.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
            ],
          ),
        ),
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
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: SECONDARY_COLOR),
      body: LayoutBuilder(builder: (context, constraints) {
        return ValueListenableBuilder<List<Metrics>>(
          valueListenable: controller.resultNotifier,
          builder: (context, metrics, child) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                color: metrics.length == 0 || metrics[0].temperature < 31
                    ? PRIMARY_COLOR
                    : Color.fromARGB(255, 3, 0, 0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32.0),
                  Text(
                    globalRepository.user != null
                        ? "Bem vindo,\n " +
                            globalRepository.user.toString() +
                            "!"
                        : "Bem vindo",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Container(
                        child: metrics.length == 0
                            ? const Center(
                                child: Text(
                                "Carregando...",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ))
                            : renderCircle(metrics[0])),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      "O aplicativo oferece recursos de alerta instantâneo para os responsáveis. Sempre que a temperatura ambiente ultrapassa o limite pré-estabelecido de 30°C",
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
                      "Desenvolvido por:\n Eduarda Sodré, Gabriel Bertusi e Lucas Fonseca ",
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
