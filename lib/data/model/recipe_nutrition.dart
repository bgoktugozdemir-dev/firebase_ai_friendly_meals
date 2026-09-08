import 'package:equatable/equatable.dart';
import 'package:firebase_ai_friendly_meals/core/utils/json_parsers.dart';

class RecipeNutrition extends Equatable {
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fat;

  const RecipeNutrition({
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
  });

  factory RecipeNutrition.fromJson(Map<String, dynamic> json) {
    return RecipeNutrition(
      calories: JsonParsers.asDouble(json['calories']),
      protein: JsonParsers.asDouble(json['protein']),
      carbohydrates: JsonParsers.asDouble(json['carbohydrates']),
      fat: JsonParsers.asDouble(json['fat']),
    );
  }

  RecipeNutrition copyWith({
    double? calories,
    double? protein,
    double? carbohydrates,
    double? fat,
  }) {
    return RecipeNutrition(
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      fat: fat ?? this.fat,
    );
  }

  @override
  List<Object?> get props => [calories, protein, carbohydrates, fat];
}
