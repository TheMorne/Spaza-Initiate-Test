part of 'simple_calc_cubit.dart';

abstract class SimpleCalcState extends Equatable {
  @override
  List<Object> get props => [];
}

class SimpleCalcCalculated extends SimpleCalcState {
  SimpleCalcCalculated(this.breakdown, this.totalChange, this.errorMsg);

  final Map<String, num> breakdown;
  final num totalChange;
  final String errorMsg;

  @override
  List<Object> get props => [breakdown, totalChange, errorMsg];
}