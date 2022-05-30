// ignore_for_file: constant_identifier_names

enum MyIcon {
  START('assets/images/start.svg'),
  LIGHT('assets/images/light.svg'),
  DARK('assets/images/dark.svg'),
  REVIEW('assets/images/review.svg'),
  BACK('assets/images/back.svg'),
  CLOCK('assets/images/clock.svg'),
  LOGOUT('assets/images/logout.svg'),
  SUBMIT('assets/images/submit.svg');

  final String value;
  const MyIcon(this.value);
}
