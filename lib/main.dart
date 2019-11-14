import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calculator/controller/calculator_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<CalculatorController>(
        builder: (_) => CalculatorController(),
        child: MaterialApp(
          title: 'Calculator',
          theme: ThemeData.dark(),
          home: MyHomePage(title: 'Calculator'),
        ));
  }
}
