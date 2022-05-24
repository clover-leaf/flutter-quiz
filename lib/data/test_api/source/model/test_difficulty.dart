// ignore_for_file: public_member_api_docs, sort_constructors_first

class TestDifficulty {
  const TestDifficulty({
    required this.label,
  });

  final String label;

  static const Map<String, String> decodeMap = {
    'Hard': 'hard',
    'Medium': 'medium',
    'Easy': 'easy',
    'Any': 'any',
  };

  static List<String> getAll() {
    return decodeMap.keys.toList();
  }

  static String getValue(String label) {
    if (decodeMap.containsKey(label)) {
      return decodeMap[label]!;
    }
    throw Exception('Cant find value');
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TestDifficulty && other.label == label;
  }

  @override
  int get hashCode => label.hashCode;
}
