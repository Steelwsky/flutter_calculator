import 'package:flutter/cupertino.dart';
import 'package:flutter_calculator/state/calculator_state.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/number_symbols.dart';
import 'dart:developer' as developer;

//---DONE str нельзя убирать, из-за некоторых моментов типа += string; текущий str не менять, добавить только stateResult.value = CalculatorState(str); ---DONE

class CalculatorController {
  final ValueNotifier<CalculatorState> stateResult =
      ValueNotifier(CalculatorState('0'));

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

  var str = '0';

  final List<String> _listClear = const ['C', 'AC'];
  var clear = 'AC';

  void onNumber(String strNumber) {
    clear = _listClear[0];
    if (isAfterEqual) {
      developer.log('isAfterEqual', name: 'onNumber');
      strForTVMain = "";
      isAfterEqual = false;
    }
    if (!isLastOfAllNumeric) {
      developer.log("isLastOfAllNumeric", name: "ONNUMBER");
      str = '';
      stateResult.value = CalculatorState(str);
    }
    if (checkForLastOperator() == true) {
      developer.log("checkForLastOperator", name: "ONNUMBER");
      str = '';
      stateResult.value = CalculatorState(str);
    }
    isLastOperator = false;
    isFullClear = false;
    forTvMain(strNumber);
    isLastOfAllNumeric = true;
  }

  void forTvMain(String strNumber) {
    isNumberEmpty = false;
    developer.log("strForTVMain: $strForTVMain, str: ${stateResult.value}",
        name: "forTVMain INIT");
    if (strForTVMain.length < 9) {
      strForTVMain += strNumber;
      if (strForTVMain.contains(".")) {
        final helper = strForTVMain.replaceAll(".", ",");
        developer.log("helper.toString:$helper", name: "FORTVMAIN");
        str = helper;
        stateResult.value = CalculatorState(str);
        return;
      }
      final beautyStr = double.parse(strForTVMain);
      developer.log("before decimalHelper strForTVMain.toDouble: $beautyStr",
          name: "forTVMain");
      decimalHelper(beautyStr);
    }
  }

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
    str = f.format(number);
    stateResult.value = CalculatorState(str);
    developer.log('number after is: $str',
        name: 'decimalHelper');
  }

  bool checkForLastOperator() {
    if (isLastOperator) {
      developer.log("isNotEmpty is done", name: "stm");
      tryError = false;
      saveNumber();
      developer.log("FN: $firstNumber or SN:$secondNumber", name: "stm");
      return true;
    } else
      return false;
  }

  void saveNumber() {
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
  }

  // ---DONE Invalid double 7,5 ---DONE
  //TODO с провайдером не совсем подходит текущая реализация.
  void onDecimal(String string) {
    developer.log(
        "isNumberEmpty :$isNumberEmpty and strFor: $strForTVMain, isLastOfAllNumeric: $isLastOfAllNumeric, isDPhere: $isDPhere",
        name: "onDecimal");
    if (isAfterEqual) {
      onClear();
    }
    if (isNumberEmpty) {
        str += ',';
      stateResult.value = CalculatorState(str);
      strForTVMain = "0.";
      isDPhere = true;
      isNumberEmpty = false;
      return null;
    }
    if (checkForLastOperator()) {
      developer.log("checkForLastOperator, isNumberEmpty: $isNumberEmpty",
          name: "onDecimal");
      str = "0,";
      stateResult.value = CalculatorState(str);
      strForTVMain = "0.";
      isLastOperator = false;
      isFirstNumber = false;
      return null;
    }
    // isLastOfAllNumeric нужен, иначе крашится при ", ="
    if (isLastOfAllNumeric && !isDPhere) {
      str += ',';
      stateResult.value = CalculatorState(str);
      strForTVMain += ".";
      developer.log("strForTVMain: $strForTVMain", name: "HEEEEELP");
      isDPhere = true;
    } else
      return null;
  }

  void onPercentage() {
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
        decimalHelper(secondNumber);
      }
  }

  void onPlusMinus() {
      if (strForTVMain.isEmpty) {
        return null;
      }
      if (strForTVMain.contains(".")) {
        strForTVMain = (double.parse(strForTVMain) * -1).toString();
      } else {
        strForTVMain = (int.parse(strForTVMain) * -1).toString();
      }
      developer.log("strForTVMAIN: $strForTVMain", name: "ONPLUSMINUS");
      decimalHelper(double.parse(strForTVMain));
  }

  void onClear() {
      secondNumber = 0.0;
      str = "0";
      stateResult.value = CalculatorState(str);
      isDPhere = false;
      strForTVMain = "";
      clear = _listClear[1];
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
        developer.log("**********************CLEARED**********************",
            name: "steelwsky");
      }
      isFullClear = true;
  }

  void onEqual() {
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
        onClear();
        developer.log("strTVMain = null, onEqual EXIT", name: "STM");
      }
      if (!tryError) {
        developer.log(
            "BEFORE MATHFUN newOpr: $newOpr  firstNumber: $firstNumber  secondNumber: $secondNumber",
            name: "STM");
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
  }

  void math(String operation, double first, double second) {
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
              stateResult.value = CalculatorState(str);
          }
          break;
      }
      isFirstNumber = false;
      strForTVMain = firstNumber.toString();
      developer.log("mathEND   $firstNumber", name: "steelwsky");
      final _forDecimalHelper = decimalHelper(firstNumber);
      //---DONE forDecimalHelper:null, null.length ????? - убрал str = forDecimalHelper
      developer.log(
          "forDecimalHelper:$_forDecimalHelper, $_forDecimalHelper.length",
          name: "STM");
  }

  void onOperator(String operator) {
      isDPhere = false;
      isLastOperator = true;
      if (!isFirstNumber) {
        onEqual();
      }
      newOpr = operator;
      isAfterEqual = false;
      developer.log("HERE IS MY OPERATOR: $newOpr", name: "steelwsky");
  }
}
