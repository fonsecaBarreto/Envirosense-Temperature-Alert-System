import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:audioplayers/audioplayers.dart';

import 'dart:async';

final urlPrefix = 'https://powerful-coast-66741-2297863c9d9a.herokuapp.com';
final kUrl2 = '$urlPrefix/beep.mp3';

class Metrics {
  int timestamp;
  double temperature;
  double humidity;
  Metrics(this.timestamp, this.humidity, this.temperature);

  @override
  String toString() {
    return "${this.timestamp} - ${this.humidity} - ${this.temperature}";
  }
}

class HomeController {
  final resultNotifier = ValueNotifier<Metrics?>(null);
  final AudioPlayer audioPlayer = AudioPlayer();
  late var bytes;

  Future loadBeep() async {
    print("baixnado beep...");
    bytes = await readBytes(Uri.parse(kUrl2));
    print(bytes);
  }

  Future playBeep() async {
    PlayerState playerState = await audioPlayer.state;
    if (playerState == PlayerState.PLAYING) return;
    if (bytes == null) return;
    audioPlayer.playBytes(bytes);
  }

  Future stopBeep() async {
    PlayerState playerState = await audioPlayer.state;
    if (playerState == PlayerState.STOPPED) return;
    await audioPlayer.stop();
  }

  Future handleTemperature(double temperature) async {
    if (temperature > 40) {
      playBeep();
    } else {
      stopBeep();
    }
  }

  Future<void> makeGetRequest() async {
    try {
      print('****** request *******');
      Response response = await get(Uri.parse('$urlPrefix/metrics'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);

        Metrics metrics = Metrics(
            0,
            (jsonMap['humidity'] == null)
                ? 0.0
                : (jsonMap['humidity'] as num).toDouble(),
            (jsonMap['temperature'] == null)
                ? 0.0
                : (jsonMap['temperature'] as num).toDouble());

        handleTemperature(metrics.temperature);
        resultNotifier.value = metrics;
      } else {
        // Request failed
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (exception, stackTrace) {
      print('An error occurred: $exception $stackTrace');
      resultNotifier.value = null;
    }
  }

  Future<void> mockMetrics(double temperature) async {
    try {
      Metrics metrics = Metrics(0, 90, temperature);
      resultNotifier.value = metrics;
    } catch (exception, stackTrace) {
      print('An error occurred: $exception $stackTrace');
      resultNotifier.value = null;
    }
  }
}
