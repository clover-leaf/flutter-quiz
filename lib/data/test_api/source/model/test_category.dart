// ignore_for_file: public_member_api_docs, sort_constructors_first

class TestCategory {

  const TestCategory({
    required this.label,
  });

  final String label;

  static const Map<String, String> decodeMap = {
    'History': '23',
    'Sport': '21',
    'Art': '25',
    'Geography': '22',
    'Mathematic': '19',
    'Computer': '18',
    'Manga': '31',
    'Any': '0',
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

    return other is TestCategory && other.label == label;
  }

  @override
  int get hashCode => label.hashCode;
}
