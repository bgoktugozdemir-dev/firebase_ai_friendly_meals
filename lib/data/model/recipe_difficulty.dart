enum RecipeDifficulty {
  easy,
  medium,
  hard;

  String get displayName => switch (this) {
    easy => 'Easy',
    medium => 'Medium',
    hard => 'Hard',
  };

  static RecipeDifficulty fromJson(String value) {
    return RecipeDifficulty.values.byName(value);
  }

  static List<String> get allValues =>
      RecipeDifficulty.values.map((e) => e.name).toList();
}
