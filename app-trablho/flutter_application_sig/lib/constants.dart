import 'package:flutter/material.dart';

final urlPrefix = 'https://powerful-coast-66741-2297863c9d9a.herokuapp.com';
final kUrl2 = '$urlPrefix/beep.mp3';

const PRIMARY_COLOR = Color.fromARGB(255, 3, 27, 69);
const SECONDARY_COLOR = Color.fromARGB(255, 4, 17, 41);

final PRIMARY_GRADIENT = LinearGradient(
  colors: [Colors.black, Color.fromARGB(255, 4, 17, 41)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

final SECONDARY_GRADIENT = LinearGradient(
  colors: [Colors.black, Colors.black, Color.fromARGB(255, 2, 15, 39)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
