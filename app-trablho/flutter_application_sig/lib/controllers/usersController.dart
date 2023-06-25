import 'dart:convert';

import 'package:flutter_application_sig/domain/models.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import '../constants.dart';

class UsersController {
  final resultNotifier = ValueNotifier<List<User>>([]);

  Future<void> makeGetRequest() async {
    try {
      print('****** Loading Users here *******');
      resultNotifier.value = [];
      Response response = await get(Uri.parse('$urlPrefix/users'));
      if (response.statusCode == 200) {
        List<dynamic> usersjsonMap = json.decode(response.body);
        List<User> users = usersjsonMap.map((jsonMap) {
          return User(jsonMap['_id'], jsonMap['email']);
        }).toList();

        resultNotifier.value = users;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (exception, stackTrace) {
      print('An error occurred: $exception $stackTrace');
      resultNotifier.value = [];
    }
  }
}
