import 'package:flutter/material.dart';
import 'package:flutter_calculator/assets/my_flutter_app_icons.dart';
import 'package:flutter_calculator/controller/calculator_controller.dart';
import 'package:flutter_calculator/settings/btn_settings.dart';
import 'package:flutter_calculator/widgets/clear_button.dart';
import 'package:flutter_calculator/widgets/result_view.dart';
import 'package:provider/provider.dart';

import 'widgets/ic_operator_button.dart';
import 'widgets/string_button.dart';
import 'widgets/zero_button.dart';
import 'widgets/ic_none_oper_button.dart';

//TODO отдельную страницу с историей расчетов. Переход боковым свайпом по любой части экрана. На втором экране будет кнопка сброса истории.
//TODO сохранение str при тапе на textview.
//TODO конкретный operator_button светить другим цветом, если последнее нажатие - этот оператор
//TODO textview 999 999 999 999 999 - поместить большие числа на одной строке
//TODO изучить чужие проекты, понять, как правильно записывают функции, как их инициализируют в buttons, а также понять, почему --- IN PROCESS

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final CalculatorController calculatorController =
        Provider.of<CalculatorController>(context);
    final ButtonSettings buttonSettings = ButtonSettings();
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ResultView(),
              Row(
                children: <Widget>[
                  ClearButton(
                      'AC',
                      buttonSettings.listBackground[0],
                      buttonSettings.listColorsFonts[0],
                      calculatorController.onClear),
                  NoOperatorButton(
                      MyCustomIcons.plusMinusIcon,
                      buttonSettings.listBackground[0],
                      buttonSettings.listColorsFonts[0],
                      calculatorController.onPlusMinus),
                  NoOperatorButton(
                      MyCustomIcons.percentSecIcon,
                      buttonSettings.listBackground[0],
                      buttonSettings.listColorsFonts[0],
                      calculatorController.onPercentage),
                  OperatorButton(
                      34.0,
                      '/',
                      MyCustomIcons.divideIcon,
                      buttonSettings.listBackground[1],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onOperator),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  StringButton(
                      '7',
                      buttonSettings.listBackground[2],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onNumber),
                  StringButton(
                      '8',
                      buttonSettings.listBackground[2],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onNumber),
                  StringButton(
                      '9',
                      buttonSettings.listBackground[2],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onNumber),
                  OperatorButton(
                      38.0,
                      '*',
                      Icons.clear,
                      buttonSettings.listBackground[1],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onOperator),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  StringButton(
                      '4',
                      buttonSettings.listBackground[2],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onNumber),
                  StringButton(
                      '5',
                      buttonSettings.listBackground[2],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onNumber),
                  StringButton(
                      '6',
                      buttonSettings.listBackground[2],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onNumber),
                  OperatorButton(
                      38.0,
                      '-',
                      MyCustomIcons.minusIcon,
                      buttonSettings.listBackground[1],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onOperator),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  StringButton(
                      '1',
                      buttonSettings.listBackground[2],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onNumber),
                  StringButton(
                      '2',
                      buttonSettings.listBackground[2],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onNumber),
                  StringButton(
                      '3',
                      buttonSettings.listBackground[2],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onNumber),
                  OperatorButton(
                      38.0,
                      '+',
                      Icons.add,
                      buttonSettings.listBackground[1],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onOperator),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  ZeroButton(
                      '0',
                      buttonSettings.listBackground[2],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onNumber),
                  StringButton(
                      '.',
                      buttonSettings.listBackground[2],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onDecimal),
                  NoOperatorButton(
                      MyCustomIcons.equalsIcon,
                      buttonSettings.listBackground[1],
                      buttonSettings.listColorsFonts[1],
                      calculatorController.onEqual),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        )));
  }
}
