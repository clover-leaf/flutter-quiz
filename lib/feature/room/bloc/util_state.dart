part of 'util_bloc.dart';

class UtilState extends Equatable {
  const UtilState(this.tapIndex, this.isScroll,
      {this.isCloseTab = false,
      this.isOpenTab = false,
      this.offsetDx = 0,
      this.offsetDy = 0});

  final int tapIndex;
  final bool isScroll;
  final double offsetDx;
  final double offsetDy;
  final bool isOpenTab;
  final bool isCloseTab;

  @override
  List<Object> get props => [
        tapIndex,
        isScroll,
        offsetDx,
        offsetDy,
        isOpenTab,
        isCloseTab
      ];

  UtilState copyWith({
    int? tapIndex,
    bool? isScroll,
    double? offsetDx,
    double? offsetDy,
    bool? isOpenTab,
    bool? isCloseTab,
  }) {
    return UtilState(
      tapIndex ?? this.tapIndex,
      isScroll ?? this.isScroll,
      offsetDx: offsetDx ?? this.offsetDx,
      offsetDy: offsetDy ?? this.offsetDy,
      isOpenTab: isOpenTab ?? this.isOpenTab,
      isCloseTab: isCloseTab ?? this.isCloseTab,
    );
  }
}
