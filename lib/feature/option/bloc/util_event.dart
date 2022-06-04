part of 'util_bloc.dart';

abstract class UtilEvent extends Equatable {
  const UtilEvent();

  @override
  List<Object> get props => [];
}

class ChangeDifficulty extends UtilEvent {
  final int index;
  const ChangeDifficulty(this.index);
  @override
  List<Object> get props => [index];
}

class ChangeCategory extends UtilEvent {
  final int index;
  const ChangeCategory(this.index);
  @override
  List<Object> get props => [index];
}

class ChangeDuration extends UtilEvent {
  final TestDuration duration;
  const ChangeDuration(this.duration);
  @override
  List<Object> get props => [duration];
}

class ChangeAmount extends UtilEvent {
  final int amount;
  const ChangeAmount(this.amount);
  @override
  List<Object> get props => [amount];
}

class ChangeTab extends UtilEvent {
  final int tabIndex;
  const ChangeTab(this.tabIndex);
  @override
  List<Object> get props => [tabIndex];
}




class ChangeType extends UtilEvent {
  final int index;
  const ChangeType(this.index);
  @override
  List<Object> get props => [index];
}
