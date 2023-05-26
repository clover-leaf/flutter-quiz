import 'package:bloc/bloc.dart';
import 'package:chicken/common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'util_event.dart';
part 'util_state.dart';

class UtilBloc extends Bloc<UtilEvent, UtilState> {
  UtilBloc({required deviceHeight, required initOffset})
      : _deviceHeight = deviceHeight,
        super(UtilState(-1, false, offsetDy: initOffset, offsetDx: Constant.SIDETAB_OFFSET.value)) {
    on<ScrollRequest>(_onScrollRequest);
    on<ScrollSuccess>(_onScrollSuccess);
    on<MoveButton>(_onMoveButton);
    on<DragDxEnd>(_onDragDxEnd);
    on<ToggleTab>(_onToggleTab);
    on<OpenTabEnd>(_onOpenTabEnd);
    on<CloseTabEnd>(_onCloseTabEnd);
  }

  final double _deviceHeight;

  void _onScrollRequest(ScrollRequest event, Emitter<UtilState> emit) {
    return emit(state.copyWith(tapIndex: event.quizIndex, isScroll: true));
  }

  void _onScrollSuccess(ScrollSuccess event, Emitter<UtilState> emit) {
    return emit(state.copyWith(isScroll: false));
  }

  void _onMoveButton(MoveButton event, Emitter<UtilState> emit) {
    if (state.isOpenTab || state.isCloseTab) {
      return;
    }
    UtilState newState = state.copyWith();
    if (state.offsetDx - event.dx >= Constant.SIDETAB_OFFSET.value &&
        state.offsetDx - event.dx <= Constant.SIDETAB_WIDTH.value) {
      newState = newState.copyWith(offsetDx: state.offsetDx - event.dx);
    }

    if (state.offsetDy + event.dy >= Constant.SIDETAB_OFFSET.value &&
        state.offsetDy + event.dy <= _deviceHeight - 3 * Constant.SIDETAB_BUTTON_A.value) {
      newState = newState.copyWith(offsetDy: state.offsetDy + event.dy);
    }
    emit(newState);
  }

  void _onDragDxEnd(DragDxEnd event, Emitter<UtilState> emit) {
    if (state.offsetDx >= Constant.SIDETAB_WIDTH.value / 2) {
      emit(state.copyWith(isOpenTab: true, offsetDx: Constant.SIDETAB_WIDTH.value));
    } else {
      emit(state.copyWith(isCloseTab: true, offsetDx: Constant.SIDETAB_OFFSET.value));
    }
  }

  void _onOpenTabEnd(OpenTabEnd event, Emitter<UtilState> emit) {
    emit(state.copyWith(isOpenTab: false));
  }

  void _onToggleTab(ToggleTab event, Emitter<UtilState> emit) {
    if (state.offsetDx == Constant.SIDETAB_WIDTH.value) {
      emit(state.copyWith(isCloseTab: true, offsetDx: Constant.SIDETAB_OFFSET.value));
    } else {
      emit(state.copyWith(isOpenTab: true, offsetDx: Constant.SIDETAB_WIDTH.value));
    }
  }

  void _onCloseTabEnd(CloseTabEnd event, Emitter<UtilState> emit) {
    if (state.isScroll) {
      event.controller.jumpTo(index: state.tapIndex, alignment: 0.01);
    }
    emit(state.copyWith(isCloseTab: false));
  }
}
