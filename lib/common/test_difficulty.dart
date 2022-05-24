
enum TestDifficulty {
  easy('easy', 'Easy', 'assets/images/difficulty.svg'),
  medium('medium', 'Medium', 'assets/images/difficulty.svg'),
  hard('hard', 'Hard', 'assets/images/difficulty.svg'),
  any('any', 'Any', 'assets/images/difficulty.svg');

  final String value;
  final String label;
  final String iconUrl;
  const TestDifficulty(this.value, this.label, this.iconUrl);
}