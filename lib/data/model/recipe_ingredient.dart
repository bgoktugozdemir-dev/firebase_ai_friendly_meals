import 'package:equatable/equatable.dart';
import 'package:firebase_ai_friendly_meals/core/utils/json_parsers.dart';
import 'package:firebase_ai_friendly_meals/data/model/recipe_ingredient_unit.dart';

class RecipeIngredient extends Equatable {
  final String name;
  final double quantity;
  final RecipeIngredientUnit unit;

  const RecipeIngredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeIngredient(
      name: json['name'] as String,
      quantity: JsonParsers.asDouble(json['quantity']),
      unit: RecipeIngredientUnit.fromJson(json['unit'] as String),
    );
  }

  RecipeIngredient copyWith({
    String? name,
    double? quantity,
    RecipeIngredientUnit? unit,
  }) {
    return RecipeIngredient(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }

  @override
  List<Object?> get props => [name, quantity, unit];
}
