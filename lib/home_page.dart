import 'package:flutter/material.dart';
import 'package:flutter_calculator/assets/my_flutter_app_icons.dart';
import 'package:flutter_calculator/equals_button.dart';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/number_symbols.dart';

import 'round_button_icon.dart';
import 'round_button.dart';
import 'rounded_zero_button.dart';

//TODO как было бы лучше, один виджет кнопки, но с ненужными аргументами в методах, или много похожих виджетов, но порядок с методами? Разные виджеты могут помочь с размерами иконок, наверн.
//TODO сделать разные виджеты
//TODO textview 999 999 999 999 999 - поместить большие числа на одной строке
//TODO создать для кнопок свой класс и вместить сюда provider.

//TODO сделать весь дизайн:
//---DONE сделать кастомные иконки с %, +-, / и т.д. --- DONE
//---DONE на кнопки нацепить функции (слизать с kotlincalc) в качестве аргумента при добавлении в layout
//TODO понять как правильно располагать виджеты на экране. Какие аналоги gravity есть. Как получить копию дизайна с котлина?
//---DONE NumberFormat (DecimalFormat) https://api.flutter.dev/flutter/intl/NumberFormat-class.html
//TODO иконки разных размеров. Как сделать одного??? Разные виджеты видимо
//TODO все значения (0-9, AC, мб еще %, +- ...) сделать const.
//TODO изучить чужие проекты, понять, как правильно записывают функции, как их инициализируют в buttons, а также понять, почему --- IN PROCESS

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

  static const MATHERROR = "Error";
  static const DECIMALFORMAT = '#,###.#####';

  var isLastOfAllNumeric = false;
  var isLastOperator = false;
  var isDPhere = false;
  var isFirstNumber = true;
  var tryError = true;
  var isAfterEqual = false;
  var firstNumber = 0.0;
  var secondNumber = 0.0;
  var isPercentage = false;
  var newOpr = "";
  var isNumberEmpty = true;
  var isFullClear = false;
  var strForTVMain = "";
// str - String для UI
  var str = '0';

//TODO ppp - просто заглушка, причем плохая, нужно переделывать, и сделать без нее (необходимо для Buttons ввести несколько конструкторов)
  var ppp = '';

//  NumberSymbols numberFormatSymbols;

  void onNumber(String strNumber) {
    setState(() {
      if (isAfterEqual) {
        developer.log('isAfterEqual', name: 'onNumber');
        strForTVMain = "";
        isAfterEqual = false;
      }
      if (!isLastOfAllNumeric) {
        developer.log("isLastOfAllNumeric", name: "ONNUMBER");
        str = "";
      }
      if (checkForLastOperator() == true) {
        developer.log("checkForLastOperator", name: "ONNUMBER");
        str = "";
      }
      isLastOperator = false;
      isFullClear = false;
      forTvMain(strNumber);
      isLastOfAllNumeric = true;
    });
  }

  void forTvMain(String strNumber) {
    isNumberEmpty = false;
    developer.log("strForTVMain: $strForTVMain, str: $str",
        name: "forTVMain INIT");
    setState(() {
      if (strForTVMain.length < 9) {
        strForTVMain += strNumber;
//        developer.log("HEEEEELP", name: "strForTVMain: $strForTVMain");
        if (strForTVMain.contains(".")) {
          final helper = strForTVMain.replaceAll(".", ",");
          developer.log("helper.toString:$helper", name: "FORTVMAIN");
          str = helper;
          return;
        }
        final beautyStr = double.parse(strForTVMain);
        developer.log("before decimalHelper strForTVMain.toDouble: $beautyStr",
            name: "forTVMain");
//        str = decimalHelper(beautyStr);
        decimalHelper(beautyStr);
//        developer.log("after decimalHelper strForTVMain: $strForTVMain, str: $str", name: "forTVMain");
      }
//      else return null;
    });
  }

  //---DONE problema raboti etogo methoda, string ne menyaet format i uhodit v null
  decimalHelper(double number) {
    developer.log('number before is: $number', name: 'decimalHelper');
    numberFormatSymbols['zz'] = new NumberSymbols(
      NAME: "zz",
      DECIMAL_SEP: ',',
      GROUP_SEP: '\u00A0',
      PERCENT: '%',
      ZERO_DIGIT: '0',
      PLUS_SIGN: '+',
      MINUS_SIGN: '-',
      EXP_SYMBOL: 'e',
      PERMILL: '\u2030',
      INFINITY: '\u221E',
      NAN: 'NaN',
      DECIMAL_PATTERN: '# ##0.###',
      SCIENTIFIC_PATTERN: '#E0',
      PERCENT_PATTERN: '#,##0%',
      CURRENCY_PATTERN: '\u00A4#,##0.00',
      DEF_CURRENCY_CODE: 'AUD',
    );
    final f = new NumberFormat('#,###.#####', 'zz');
    setState(() {
      str = f.format(number);
      developer.log('number after is: $str', name: 'decimalHelper');
    });
  }

  bool checkForLastOperator() {
//    setState(() {
    if (isLastOperator) {
      developer.log("isNotEmpty is done", name: "stm");
      tryError = false;
      saveNumber();
      developer.log("FN: $firstNumber or SN:$secondNumber", name: "stm");
      return true;
    } else
      return false;
//    });
  }

  void saveNumber() {
    setState(() {
      developer.log(
          "strMain: $strForTVMain and FN:$firstNumber, SN:$secondNumber",
          name: "BEFORE SAVENUMBER");
      if (isFirstNumber) {
        if (strForTVMain == "") {
          strForTVMain = "0";
        }
        firstNumber = double.parse(strForTVMain);
        developer.log("FN: $firstNumber", name: "SAVENUMBER");
        strForTVMain = "";
        isFirstNumber = false;
      }
    });
  }

  // ---DONE Invalid double 7,5 ---DONE
  void onDecimal(String string) {
    setState(() {
      developer.log(
          "isNumberEmpty :$isNumberEmpty and strFor: $strForTVMain, isLastOfAllNumeric: $isLastOfAllNumeric, isDPhere: $isDPhere",
          name: "onDecimal");
      if (isAfterEqual) {
        onClear(ppp);
      }
      if (isNumberEmpty) {
//        tvMain.append((view as Button).text)
        str += ',';
        strForTVMain = "0.";
        isDPhere = true;
        isNumberEmpty = false;
        return null;
      }
      // pri 0 + 0,75 = 0,75 = 75
      if (checkForLastOperator()) {
        developer.log("checkForLastOperator, isNumberEmpty: $isNumberEmpty",
            name: "onDecimal");
        str = "0,";
        strForTVMain = "0.";
        isLastOperator = false;
        // postavil isFirstNumber = false i teper posle onCleat eta tema ne rabotaet ??? 10.10.19 - hz o chem eto bilo, vrode pofiksil
        isFirstNumber = false;
        return null;
      }
      // isLastOfAllNumeric нужен, иначе крашится при ", ="
      if (isLastOfAllNumeric && !isDPhere) {
//        tvMain.append((view as Button).text)
        str += ',';
        strForTVMain += ".";
        developer.log("strForTVMain: $strForTVMain", name: "HEEEEELP");
        isDPhere = true;
      } else
        return null;
    });
  }

  void onPercentage(ppp) {
    setState(() {
      isPercentage = true;
      if (isFirstNumber) {
        isFirstNumber = false;
        secondNumber = 0.01;
        newOpr = "*";
        onEqual();
      } else {
        if (newOpr == "+" || newOpr == "-") {
          secondNumber = firstNumber * double.parse(strForTVMain) * 0.01;
          developer.log("onPercentage, else +++ -> SN: $secondNumber",
              name: "STM");
        } else {
          secondNumber = double.parse(strForTVMain) * 0.01;
          developer.log("onPercentage, else *** -> SN: $secondNumber",
              name: "STM");
        }
//        str = decimalHelper(secondNumber);
        decimalHelper(secondNumber);
      }
    });
  }

  void onPlusMinus(ppp) {
    setState(() {
      if (strForTVMain.isEmpty) {
        return null;
      }
//  strForTVMain = if (strForTVMain.contains(".")) {
      if (strForTVMain.contains(".")) {
        strForTVMain = (double.parse(strForTVMain) * -1).toString();
      } else {
        strForTVMain = (int.parse(strForTVMain) * -1).toString();
      }
      developer.log("strForTVMAIN: $strForTVMain", name: "ONPLUSMINUS");
//      str = decimalHelper(double.parse(strForTVMain));
      decimalHelper(double.parse(strForTVMain));
    });
  }

  void onClear(String ppp) {
    setState(() {
      secondNumber = 0.0;
      str = "0";
      isDPhere = false;
      strForTVMain = "";
//    buttonAC.text = getString(R.string.ac);
      isNumberEmpty = true;
      isPercentage = false;
      developer.log("isFullClear: $isFullClear", name: "onClear");
      developer.log("***********SN IS CLEARED***********", name: "steelwsky");
      if (isFirstNumber || isFullClear) {
        isFirstNumber = true;
        firstNumber = 0.0;
        isLastOfAllNumeric = false;
        isLastOperator = false;
        newOpr = "";
        tryError = true;
        isAfterEqual = false;
//      tvMain.setTextSize(TypedValue.COMPLEX_UNIT_SP, 60f)
        developer.log("**********************CLEARED**********************",
            name: "steelwsky");
      }
      isFullClear = true;
    });
  }

  void onEqual() {
    setState(() {
      developer.log("onEqual INIT", name: "STM");
      if (isFullClear && isNumberEmpty) {
        strForTVMain = firstNumber.toString();
        developer.log("onEqual, isFullClear = true, strTVMain: $strForTVMain",
            name: "STM");
      }
      if (!isFirstNumber && !isPercentage) {
        secondNumber = double.parse(strForTVMain);
        developer.log("onEqual !isFirstNumber", name: "STM");
      }
      if (strForTVMain == ("")) {
        onClear(ppp);
        developer.log("strTVMain = null, onEqual EXIT", name: "STM");
      }
      if (!tryError) {
        developer.log(
            "BEFORE MATHFUN newOpr: $newOpr  firstNumber: $firstNumber  secondNumber: $secondNumber",
            name: "STM");
//      str = math(newOpr, firstNumber, secondNumber);
        math(newOpr, firstNumber, secondNumber);
        newOpr = "";
        isLastOfAllNumeric = false;
        isFirstNumber = true;
        isAfterEqual = true;
        isDPhere = false;
        isPercentage = false;
        developer.log('onEqual EXIT', name: "STM");
        tryError = true;
        isFullClear = false;
      } else {
        tryError = false;
        firstNumber = double.parse(strForTVMain);
        isFirstNumber = false;
        isLastOperator = false;
        developer.log("tryError is now FALSE", name: 'STM');
        onEqual();
      }
    });
  }

  void math(String operation, double first, double second) {
    setState(() {
      developer.log("mathINIT, newOpr is: $newOpr", name: "steelwsky");
      switch (operation) {
        case "+":
          {
            firstNumber = (first + second);
            developer.log("WeAreInside  $first + $second = $firstNumber",
                name: "steelwsky");
          }
          break;
        case "-":
          {
            firstNumber = (first - second);
            developer.log("WeAreInside  $first - $second = $firstNumber",
                name: "steelwsky");
          }
          break;
        case "*":
          {
            firstNumber = (first * second);
            developer.log("WeAreInside  $first * $second = $firstNumber",
                name: "steelwsky");
          }
          break;
        case "/":
          {
            if (second != 0.0) {
              firstNumber = (first / second);
              developer.log("WeAreInside  $first / $second = $firstNumber",
                  name: "steelwsky");
            } else
              str = MATHERROR;
          }
          break;
      }
      isFirstNumber = false;
      strForTVMain = firstNumber.toString();
      developer.log("mathEND   $firstNumber", name: "steelwsky");
//      final forDecimalHelper = decimalHelper(firstNumber);
      final _forDecimalHelper = decimalHelper(firstNumber);
      //---DONE forDecimalHelper:null, null.length ????? - убрал str = forDecimalHelper
      developer.log(
          "forDecimalHelper:$_forDecimalHelper, $_forDecimalHelper.length",
          name: "STM");
//      return forDecimalHelper;
    });
  }

//hz kak tut
  void onOperator(String operator) {
    setState(() {
      isDPhere = false;
      isLastOperator = true;
      if (!isFirstNumber) {
        onEqual();
      }
      newOpr = operator;
      isAfterEqual = false;
      developer.log("HERE IS MY OPERATOR: $newOpr", name: "steelwsky");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: new Center(
            child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(16.0),
          child: new Column(
            children: [
              new Row(
                children: <Widget>[
                  Container(
//                    child: FittedBox(
//                      fit: BoxFit.fitWidth,
                    child: Text(
                      '$str',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 60.0,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
//                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(top: 134, right: 16),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
              Row(
                children: <Widget>[
                  RoundButton(
                      'AC', _listBackground[0], _listColorsFonts[0], onClear),
                  RoundButtonIcon('plusminus', MyCustomIcons.plusMinusIcon,
                      _listBackground[0], _listColorsFonts[0], onPlusMinus),
                  RoundButtonIcon('', MyCustomIcons.percentSecIcon,
                      _listBackground[0], _listColorsFonts[0], onPercentage),
                  RoundButtonIcon('/', MyCustomIcons.divideIcon,
                      _listBackground[1], _listColorsFonts[1], onOperator),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  RoundButton(
                      '7', _listBackground[2], _listColorsFonts[1], onNumber),
                  RoundButton(
                      '8', _listBackground[2], _listColorsFonts[1], onNumber),
                  RoundButton(
                      '9', _listBackground[2], _listColorsFonts[1], onNumber),
                  RoundButtonIcon('*', Icons.clear, _listBackground[1],
                      _listColorsFonts[1], onOperator),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  RoundButton(
                      '4', _listBackground[2], _listColorsFonts[1], onNumber),
                  RoundButton(
                      '5', _listBackground[2], _listColorsFonts[1], onNumber),
                  RoundButton(
                      '6', _listBackground[2], _listColorsFonts[1], onNumber),
                  RoundButtonIcon('-', MyCustomIcons.minusIcon,
                      _listBackground[1], _listColorsFonts[1], onOperator),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  RoundButton(
                      '1', _listBackground[2], _listColorsFonts[1], onNumber),
                  RoundButton(
                      '2', _listBackground[2], _listColorsFonts[1], onNumber),
                  RoundButton(
                      '3', _listBackground[2], _listColorsFonts[1], onNumber),
                  RoundButtonIcon('+', Icons.add, _listBackground[1],
                      _listColorsFonts[1], onOperator),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  ZeroButton(
                      '0', _listBackground[2], _listColorsFonts[1], onNumber),
                  RoundButton(
                      '.', _listBackground[2], _listColorsFonts[1], onDecimal),
                  //TODO '=' - nado ubrat dlya onEqual, a tak je dlya onClear
                  EqualButton(MyCustomIcons.equalsIcon, _listBackground[1],
                      _listColorsFonts[1], onEqual),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        )));
  }
}
