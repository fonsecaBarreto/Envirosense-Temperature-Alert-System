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
      height: 200,
      child: const Center(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Text(
            'O aplicativo oferece recursos de alerta instantâneo para os responsáveis. Sempre que a temperatura ambiente ultrapassa o limite pré-estabelecido de 30°C',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
