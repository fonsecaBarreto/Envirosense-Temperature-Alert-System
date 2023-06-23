import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoModal extends StatefulWidget {
  @override
  _InfoModalState createState() => _InfoModalState();
}

class _InfoModalState extends State<InfoModal> {
  bool _isVisible = false;

  void showInfoModal() {
    setState(() {
      _isVisible = true;
    });
  }

  void hideInfoModal() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            Text(
              'O aplicativo oferece recursos de alerta instantâneo para os responsáveis. Sempre que a temperatura ambiente ultrapassa o limite pré-estabelecido de 30°C',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              "Desenvolvido por:\n Eduarda Sodré, Gabriel Bertusi e Lucas Fonseca ",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
