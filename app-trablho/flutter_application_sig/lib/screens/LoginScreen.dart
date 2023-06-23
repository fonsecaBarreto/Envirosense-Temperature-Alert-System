import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_sig/repositories/global_repository.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _submitForm(GlobalRepository repository) async {
    print("submitting...");
    String email = _emailController.text;
    await repository.signUpUser(email);
  }

  @override
  Widget build(BuildContext context) {
    final globalRepository = Provider.of<GlobalRepository>(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(gradient: SECONDARY_GRADIENT),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(image: AssetImage("assets/images/logo.png")),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _submitForm(globalRepository);
              },
              child: Text(
                'ENTRAR',
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
              ),
            ),
            const SizedBox(height: 32.0),
            Text(
              "Desenvolvido por:\n Eduarda Sodré, Gabriel Bertusi e Lucas Fonseca ",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
