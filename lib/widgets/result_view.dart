import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_calculator/controller/calculator_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calculator/state/calculator_state.dart';

class ResultView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CalculatorController calculatorController =
        Provider.of<CalculatorController>(context);
    return ValueListenableBuilder<CalculatorState>(
        valueListenable: calculatorController.stateResult,
        builder: (context, newState, child) {
          return Row(
            children: <Widget>[
              Container(
                child: Text(
                  '${newState.result}',
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
          );
        });
  }
}
