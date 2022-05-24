part of 'room_bloc.dart';

abstract class RoomState extends Equatable {
  const RoomState(
      {this.answerSheet = const [],
      this.navbarIdx = -1,
      this.navbarTap = false});

  final List<Answer> answerSheet;
  final int navbarIdx;
  final bool navbarTap;

  @override
  List<Object> get props => [answerSheet, navbarIdx, navbarTap];
}

class RoomInitial extends RoomState {}

class RoomUpdating extends RoomState {
  const RoomUpdating({super.answerSheet, super.navbarIdx, super.navbarTap});
}
