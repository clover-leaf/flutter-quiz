part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}

class RoomCreated extends RoomEvent {
  final List<Quiz> quizzes;

  const RoomCreated({required this.quizzes});
}

class RoomUpdated extends RoomEvent {
  final Answer answer;

  const RoomUpdated({required this.answer});
}

class RoomNavbarTapped extends RoomEvent {
  final int index;
  final bool isTap;

  const RoomNavbarTapped({required this.index, required this.isTap});
}
class RoomNavbarReset extends RoomEvent {
}
