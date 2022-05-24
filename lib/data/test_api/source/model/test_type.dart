// ignore_for_file: public_member_api_docs, sort_constructors_first

class TestType {
  const TestType({
    required this.label,
  });

  final String label;

  static const Map<String, String> decodeMap = {
    'True / False': 'boolean',
    'Multiple Choice': 'multiple',
    'Any': 'any',
  };

  static String getValue(String label) {
    if (decodeMap.containsKey(label)) {
      return decodeMap[label]!;
    }
    throw Exception('Cant find value');
  }
  
  
  static List<String> getAll() {
    return decodeMap.keys.toList();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TestType && other.label == label;
  }

  @override
  int get hashCode => label.hashCode;
}
