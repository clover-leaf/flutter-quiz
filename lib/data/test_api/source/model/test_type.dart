import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class TestType {
  final String id;
  final String name;
  final String? iconPath;
  TestType({
    required this.id,
    required this.name,
    this.iconPath,
  });

  TestType copyWith({
    String? id,
    String? name,
    String? iconPath,
  }) {
    return TestType(
      id: id ?? this.id,
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'iconPath': iconPath,
    };
  }

  factory TestType.fromMap(Map<String, dynamic> map) {
    return TestType(
      id: map['id'] as String,
      name: map['name'] as String,
      iconPath: map['iconPath'] != null ? map['iconPath'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestType.fromJson(String source) => TestType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TestType(id: $id, name: $name, iconPath: $iconPath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TestType &&
      other.id == id &&
      other.name == name &&
      other.iconPath == iconPath;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ iconPath.hashCode;
}
