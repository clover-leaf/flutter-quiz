class TestDuration {
  const TestDuration({required this.total, required this.usedTime});

  final int total;
  final int usedTime;

  TestDuration copyWith({int? total, int? usedTime}) {
    return TestDuration(
        total: total ?? this.total, usedTime: usedTime ?? this.usedTime);
  }

  String toStr(int totalInSecond) {
    int hour = (totalInSecond / 3600).floor();
    String minute =
        ((totalInSecond % 3600) / 60).floor().toString().padLeft(2, '0');
    String second = (totalInSecond % 60).toString().padLeft(2, '0');
    return hour == 0 ? '$minute:$second' : '$hour:$minute:$second';
  }

  String getTotalTime() => toStr(total);
  String getusedTimeTime() => toStr(usedTime);
}
