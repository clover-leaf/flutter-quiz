import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class TestCategory {

  final int id;
  final String name;
  final String? iconPath;
  TestCategory({
    required this.id,
    required this.name,
    this.iconPath,
  });

  TestCategory copyWith({
    int? id,
    String? name,
    String? iconPath,
  }) {
    return TestCategory(
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

  factory TestCategory.fromMap(Map<String, dynamic> map) {
    return TestCategory(
      id: map['id'] as int,
      name: map['name'] as String,
      iconPath: map['iconPath'] != null ? map['iconPath'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestCategory.fromJson(String source) => TestCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TestCategory(id: $id, name: $name, iconPath: $iconPath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TestCategory &&
      other.id == id &&
      other.name == name &&
      other.iconPath == iconPath;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ iconPath.hashCode;
}
