enum TestCategory {
  history('23', 'History'),
  sport('21', 'Sport'),
  art('25', 'Art'),
  geography('22', 'Geography'),
  mathematic('19', 'Mathematic'),
  computer('18', 'Computer'),
  manga('31', 'Manga'),
  any('0', 'Any');

  final String value, label;

  const TestCategory(this.value, this.label);
}