import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../controllers/homeController.dart';
import '../domain/models.dart';

import '../constants.dart';

class GlobalRepository extends ChangeNotifier {
  late User? user = null;
  final controller = HomeController();

  Future<void> initialLoad(BuildContext context) async {
    print("................ Loading initial data ................");
    return;
  }

  Future<void> signUpUser(String email) async {
    print("add new user");
    try {
      print('****** request *******');
      Map data = {'email': email};
      Response response = await post(Uri.parse('$urlPrefix/users'),
          headers: {"Content-Type": "application/json"},
          body: json.encode(data));
      if (response.statusCode == 200) {
        dynamic userJson = json.decode(response.body);
        user = new User(userJson['_id'], userJson['email']);
        notifyListeners();
        print("Usuario criado com sucesso");
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (exception, stackTrace) {
      print('An error occurred: $exception $stackTrace');
    }
  }
}
