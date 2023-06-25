import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_sig/screens/InfoModal.dart';
import 'package:provider/provider.dart';
import '../components/nav_drawer.dart';
import '../constants.dart';
import '../controllers/homeController.dart';
import '../repositories/global_repository.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = HomeController();
  final ScrollController _scrollController = ScrollController();

  late Timer timer;

  void _handleLoopRequest() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      controller.makeGetRequest();
    });
  }

  @override
  void initState() {
    controller.loadBeep();
    // _handleLoopRequest();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  renderCircle(Metrics _metrics) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 2, 11, 28), width: 8),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage((_metrics.temperature < 31)
              ? "assets/images/puls10.gif"
              : "assets/images/pulse6.gif"),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(38),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${_metrics.temperature.toStringAsFixed(1)}°C",
              style: TextStyle(fontSize: 60, color: Colors.white),
            ),
            Text(
              "${_metrics.humidity.toStringAsFixed(1)}%",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderListView(List<Metrics> metrics, ScrollController controller) {
    return ListView.builder(
      controller: controller,
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        var data = metrics[index];
        return Container(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.thermostat, color: Colors.white),
            ),
            title: Text(
              data.toString(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalRepository = Provider.of<GlobalRepository>(context);

    _scrollController.addListener(() {
      print(_scrollController.offset);
    });

    return Scaffold(
      backgroundColor: Colors.orange,
      drawer: const NavDrawer(),
      appBar: AppBar(
          title: const Text(
            "EnviroSense",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return InfoModal();
                  },
                );
              },
            ),
          ],
          backgroundColor: SECONDARY_COLOR),
      body: LayoutBuilder(builder: (context, constraints) {
        return ValueListenableBuilder<List<Metrics>>(
          valueListenable: controller.resultNotifier,
          builder: (context, metrics, child) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                gradient: PRIMARY_GRADIENT,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 18.0),
                  Text(
                    globalRepository.user != null
                        ? "Bem vindo,\n " +
                            globalRepository.user.toString() +
                            "!"
                        : "Bem vindo",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
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
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        metrics.isEmpty
                            ? Text(
                                "",
                                style: TextStyle(color: Colors.white),
                              )
                            : Expanded(
                                child: _renderListView(
                                    metrics, _scrollController)),
                      ],
                    ),
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
