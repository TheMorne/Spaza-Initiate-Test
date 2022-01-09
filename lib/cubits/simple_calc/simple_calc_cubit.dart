import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'simple_calc_state.dart';

class SimpleCalcCubit extends Cubit<SimpleCalcState> {
  SimpleCalcCubit() : super(SimpleCalcCalculated({}, 0, ""));

  List<num> validDenominations = [200, 100, 50, 20, 10, 5, 2, 1, 0.50, 0.20];
  List<num> count = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  //String get errorMsg => "test";

  void calculateWithMod(double cost, double tender) {
    String errorMsg = "";
    num totalChange = tender - cost;
    num changeCal = totalChange;
    Map<String, num> breakdown = {};
    String validationMsgCost = validation(cost, "Cost");
    String validationMsgTender = validation(tender, "Tender");
    String validationMsgTotalChange = validation(totalChange, "Total Change");
    String calcCorrectCost = correctChange(cost, "Cost");
    String calcCorrectTender = correctChange(tender, "Tender");
    String calcCorrectChange = correctChange(totalChange, "Total Change");


    if (validationMsgCost == "" &&
        validationMsgTender == "" &&
        validationMsgTotalChange == "") {
      for (int i = 0; i < validDenominations.length; i++) {
        if (changeCal > validDenominations[i] ||
            changeCal == validDenominations[i]) {
          count[i] = changeCal / validDenominations[i];
          changeCal = changeCal % validDenominations[i];
          breakdown[validDenominations[i].toStringAsFixed(2)] =
              count[i].toInt();
        }
      }
    } else {
      if (validationMsgCost != "") {
        errorMsg = validationMsgCost;
      }
      if (validationMsgTender != "") {
        if (errorMsg != "") {
          errorMsg = errorMsg + " and " + validationMsgTender;
        } else {
          errorMsg = validationMsgTender;
        }
      }
      if (validationMsgTotalChange != "") {
        if (errorMsg != "") {
          errorMsg = errorMsg + " and " + validationMsgTotalChange;
        } else {
          errorMsg = validationMsgTotalChange;
        }
      }
    }
    if (calcCorrectCost != "")  {
      errorMsg = errorMsg + calcCorrectCost;
    }
    if( calcCorrectTender != ""){
      errorMsg = errorMsg + calcCorrectTender;
    }
    if(calcCorrectChange != ""){
      errorMsg = errorMsg + calcCorrectChange;
    }
    // TODO - Calculate your breakdown here, put the results in a map, with the validDenominations as the key, and the result as the value
    emit(SimpleCalcCalculated(breakdown, totalChange, errorMsg));
  }

  String validation(double num, String condition) {
    if (num < 0) {
      return condition + " cannot be less than 0";
    }
    return "";
  }

  String correctChange(double num, String condition) {
    if (num % .10 != 0) {
      return " smallest denomination is 20c therefore " +
          " " +
          condition +
          " " +
          num.toString() +
          " must be adjusted accordingly";
    }
  }
  void clearAll() {
    emit(SimpleCalcCalculated({}, 0, ""));
  }
}
