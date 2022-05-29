part of 'util_bloc.dart';

abstract class UtilEvent extends Equatable {
  const UtilEvent();

  @override
  List<Object> get props => [];
}

class ScrollRequest extends UtilEvent {
  final int quizIndex;

  const ScrollRequest(this.quizIndex);
}

class ScrollSuccess extends UtilEvent {}

class MoveButton extends UtilEvent {
  final double dx;
  final double dy;

  const MoveButton(this.dx, this.dy);
}

class DragDxEnd extends UtilEvent {}

class ToggleTab extends UtilEvent {}

class OpenTabEnd extends UtilEvent {}

class CloseTabEnd extends UtilEvent {
  final ItemScrollController controller;

  const CloseTabEnd({required this.controller});
}
