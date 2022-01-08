import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'simple_calc_state.dart';

class SimpleCalcCubit extends Cubit<SimpleCalcState> {
  SimpleCalcCubit() : super(SimpleCalcCalculated({}, 0));

  List<num> validDenominations = [200, 100, 50, 20, 10, 5, 2, 1, 0.50, 0.20];
  List<num> count = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  void calculateWithMod(double cost, double tender) {
    num totalChange = tender - cost;
    num changeCal = totalChange;
    Map<String, num> breakdown = {};

    if(tender < 0){

    }

    for (int i = 0; i < validDenominations.length; i++) {
      if (changeCal > validDenominations[i] || changeCal == validDenominations[i]) {
        count[i] = changeCal / validDenominations[i];
        changeCal = changeCal % validDenominations[i];
        breakdown[validDenominations[i].toStringAsFixed(2)] = count[i].toInt();
      }
    }

    // TODO - Calculate your breakdown here, put the results in a map, with the validDenominations as the key, and the result as the value

    emit(SimpleCalcCalculated(breakdown, totalChange));
  }

  void clearAll() {
    emit(SimpleCalcCalculated({}, 0));
  }
}
