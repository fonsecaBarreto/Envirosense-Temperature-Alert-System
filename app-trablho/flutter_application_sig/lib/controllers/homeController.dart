import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

class HomeController {
  final resultNotifier = ValueNotifier<RequestState>(RequestInitial());

  static const urlPrefix =
      'https://powerful-coast-66741-2297863c9d9a.herokuapp.com';
  Future<void> makeGetRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    print('****** Loading request *******');
    final url = Uri.parse('$urlPrefix/metrics');
    Response response = await get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    Map parsed = json.decode(response.body);
    resultNotifier.value = RequestLoadSuccess(parsed);
  }
}

class RequestState {
  const RequestState();
}

class RequestInitial extends RequestState {}

class RequestLoadInProgress extends RequestState {}

class RequestLoadSuccess extends RequestState {
  final Map body;
  const RequestLoadSuccess(this.body);
}
