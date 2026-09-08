enum RecipeIngredientUnit {
  g,
  kg,
  ml,
  l,
  cups,
  tablespoons,
  teaspoons,
  pieces;

  String get displayName => switch (this) {
    g => 'g',
    kg => 'kg',
    ml => 'ml',
    l => 'l',
    cups => 'cup',
    tablespoons => 'tbsp',
    teaspoons => 'tsp',
    pieces => 'pc',
  };

  static RecipeIngredientUnit fromJson(String value) {
    return RecipeIngredientUnit.values.byName(value);
  }

  static List<String> get allValues =>
      RecipeIngredientUnit.values.map((e) => e.name).toList();
}
