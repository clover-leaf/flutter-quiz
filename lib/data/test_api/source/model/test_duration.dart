// ignore_for_file: public_member_api_docs, sort_constructors_first, no_leading_underscores_for_local_identifiers
import 'dart:convert';

class TestDuration {
  final int total;
  final int remain;

  const TestDuration({
    required this.total,
    required this.remain,
  });

  static TestDuration fromSecond(int second) {
    return TestDuration(total: second, remain: second);
  }

  String toStr(int totalInSecond) {
    int hour = (totalInSecond / 3600).floor();
    String minute =
        ((totalInSecond % 3600) / 60).floor().toString().padLeft(2, '0');
    String second = (totalInSecond % 60).toString().padLeft(2, '0');
    return hour == 0 ? '$minute:$second' : '$hour:$minute:$second';
  }

  static String toStylishString(int second) {
    String _minute = (second / 60).floor().toString().padLeft(2, '0');
    String _second = (second % 60).toString().padLeft(2, '0');
    return '$_minute min $_second sec';
  }

  String getStylishTotal() => toStylishString(total);
  String getStylishRemain() => toStylishString(remain);
  String getStylishUsed() => toStylishString(total - remain);

  String get getUsedTime => toStr(total - remain);

  String getTotalTime() => toStr(total);
  String getRemainTime() => toStr(remain);

  TestDuration copyWith({
    int? total,
    int? remain,
  }) {
    return TestDuration(
      total: total ?? this.total,
      remain: remain ?? this.remain,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'remain': remain,
    };
  }

  factory TestDuration.fromMap(Map<String, dynamic> map) {
    return TestDuration(
      total: map['total'] as int,
      remain: map['remain'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestDuration.fromJson(String source) =>
      TestDuration.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TestDuration(total: $total, remain: $remain)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TestDuration &&
        other.total == total &&
        other.remain == remain;
  }

  @override
  int get hashCode => total.hashCode ^ remain.hashCode;
}
