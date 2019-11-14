import 'package:flutter/material.dart';
class ButtonSettings {

  final List<Color> _listColorsFonts = const [Colors.black, Colors.white];
  final List<Color> _listBackground = const [
    Color.fromARGB(255, 165, 165, 165),
    Color.fromARGB(255, 254, 149, 2),
    Color.fromARGB(255, 51, 51, 51)
  ];

  List<Color> get listColorsFonts {
    return _listColorsFonts;
  }

  List<Color> get listBackground {
    return _listBackground;
  }
}