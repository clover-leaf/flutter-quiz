
enum TestType {
  boolean('boolean', 'True / False'),
  multiple('multiple', 'Multiple Choice'),
  any('any', 'Any');

  final String value;
  final String label;
  const TestType(this.value, this.label);
}