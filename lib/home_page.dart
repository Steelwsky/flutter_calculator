import 'package:flutter/material.dart';
import 'package:flutter_calculator/assets/my_flutter_app_icons.dart';

import 'round_button_icon.dart';
import 'round_button.dart';
import 'rounded_zero_button.dart';

//TODO сделать весь дизайн:
//---DONE сделать кастомные иконки с %, +-, / и т.д. --- DONE
//TODO на кнопки нацепить функции (слизать с kotlincalc) в качестве аргумента при добавлении в layout
//TODO понять как правильно располагать виджеты на экране. Какие аналоги gravity есть. Как получить копию дизайна с котлина?
//TODO NumberFormat (DecimalFormat) https://api.flutter.dev/flutter/intl/NumberFormat-class.html
//TODO иконки разных размеров. Как сделать одного???

//final List<Map<String, Color>> _listBack = [
//  {
//    'lightGrey': Color.fromARGB(255, 165, 165, 165),
//    'yellow': Color.fromARGB(255, 254, 149, 2),
//    'darkGrey': Color.fromARGB(255, 51, 51, 51)
//  }
//];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Color> _listColorsFonts = const [Colors.black, Colors.white];
  final List<Color> _listBackground = const [
    Color.fromARGB(255, 165, 165, 165),
    Color.fromARGB(255, 254, 149, 2),
    Color.fromARGB(255, 51, 51, 51)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        body: new Center(
            child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(16.0),
          child: new Column(
            children: [
              new Row(
                children: <Widget>[
                  Container(
                    child: new Text(
                      '12345678',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 54.0,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(top: 140, right: 16),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.end,

              ),
              Row(
                children: <Widget>[
                  RoundButton('AC', _listBackground[0], _listColorsFonts[0]),
                  RoundButtonIcon(MyCustomIcons.plusMinusIcon,
                      _listBackground[0], _listColorsFonts[0]),
                  RoundButtonIcon(MyCustomIcons.percentSecIcon,
                      _listBackground[0], _listColorsFonts[0]),
                  RoundButtonIcon(MyCustomIcons.divideIcon, _listBackground[1],
                      _listColorsFonts[1]),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  RoundButton('7', _listBackground[2], _listColorsFonts[1]),
                  RoundButton('8', _listBackground[2], _listColorsFonts[1]),
                  RoundButton('9', _listBackground[2], _listColorsFonts[1]),
                  RoundButtonIcon(
                      Icons.close, _listBackground[1], _listColorsFonts[1]),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  RoundButton('4', _listBackground[2], _listColorsFonts[1]),
                  RoundButton('5', _listBackground[2], _listColorsFonts[1]),
                  RoundButton('6', _listBackground[2], _listColorsFonts[1]),
                  RoundButtonIcon(MyCustomIcons.minusIcon, _listBackground[1],
                      _listColorsFonts[1]),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  RoundButton('1', _listBackground[2], _listColorsFonts[1]),
                  RoundButton('2', _listBackground[2], _listColorsFonts[1]),
                  RoundButton('3', _listBackground[2], _listColorsFonts[1]),
                  RoundButtonIcon(
                      Icons.add, _listBackground[1], _listColorsFonts[1]),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  ZeroButton('0', _listBackground[2], _listColorsFonts[1]),
                  RoundButton(',', _listBackground[2], _listColorsFonts[1]),
                  RoundButtonIcon(MyCustomIcons.equalsIcon, _listBackground[1],
                      _listColorsFonts[1]),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        )));
  }
}
