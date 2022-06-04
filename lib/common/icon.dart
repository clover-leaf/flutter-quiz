// ignore_for_file: constant_identifier_names

enum MyIcon {
  NEXT('assets/images/next.svg'),
  START('assets/images/start.svg'),
  ERROR('assets/images/microscope.svg'),
  LIGHT('assets/images/light.svg'),
  DARK('assets/images/dark.svg'),
  REVIEW('assets/images/review.svg'),
  BACK('assets/images/back.svg'),
  CLOCK('assets/images/clock.svg'),
  LOGOUT('assets/images/logout.svg'),
  SUBMIT('assets/images/submit.svg'),

  // Difficulty
  EASY('assets/images/easy.svg'),
  MEDIUM('assets/images/medium.svg'),
  HARD('assets/images/hard.svg'),

  // Type
  TRUEFALSE('assets/images/tf.svg'),
  MULTIPLE('assets/images/multiple.svg'),

  // Category
  ANY('assets/images/any.svg'),
  ANIMAL('assets/images/animal.svg'),
  ART('assets/images/art.svg'),
  BOARDGAME('assets/images/boardgame.svg'),
  BOOK('assets/images/book.svg'),
  CELEB('assets/images/celeb.svg'),
  COMPUTER('assets/images/computer.svg'),
  FILM('assets/images/film.svg'),
  GADGET('assets/images/gadget.svg'),
  GAME('assets/images/game.svg'),
  GENERAL('assets/images/general.svg'),
  GEOGRAPHY('assets/images/geography.svg'),
  HISTORY('assets/images/history.svg'),
  MANGA('assets/images/manga.svg'),
  MATH('assets/images/math.svg'),
  MUSIC('assets/images/music.svg'),
  NATURE('assets/images/nature.svg'),
  POLITIC('assets/images/politic.svg'),
  SPORT('assets/images/sport.svg'),
  VEHICLE('assets/images/vehicle.svg');

  final String value;
  const MyIcon(this.value);
}
