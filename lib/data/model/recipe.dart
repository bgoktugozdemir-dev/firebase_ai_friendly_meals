import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:firebase_ai_friendly_meals/core/utils/json_parsers.dart';
import 'package:firebase_ai_friendly_meals/data/model/recipe_difficulty.dart';
import 'package:firebase_ai_friendly_meals/data/model/recipe_ingredient.dart';
import 'package:firebase_ai_friendly_meals/data/model/recipe_nutrition.dart';

class Recipe extends Equatable {
  final String name;
  final String description;
  final int numberOfServings;
  final double prepTime;
  final double cookTime;
  final double totalTime;
  final RecipeDifficulty difficulty;
  final List<RecipeIngredient> ingredients;
  final List<String> instructions;
  final RecipeNutrition nutrition;
  final List<String>? tips;
  final Uint8List? image;

  const Recipe({
    required this.name,
    required this.description,
    required this.numberOfServings,
    required this.prepTime,
    required this.cookTime,
    required this.totalTime,
    required this.difficulty,
    required this.ingredients,
    required this.instructions,
    required this.nutrition,
    this.tips,
    this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json, {Uint8List? image}) {
    return Recipe(
      name: json['name'] as String,
      description: json['description'] as String,
      numberOfServings: JsonParsers.asInt(json['numberOfServings']),
      prepTime: JsonParsers.asDouble(json['prepTime']),
      cookTime: JsonParsers.asDouble(json['cookTime']),
      totalTime: JsonParsers.asDouble(json['totalTime']),
      difficulty: RecipeDifficulty.fromJson(json['difficulty'] as String),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map(
            (item) => RecipeIngredient.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      instructions: (json['instructions'] as List<dynamic>).cast<String>(),
      nutrition: RecipeNutrition.fromJson(
        json['nutrition'] as Map<String, dynamic>,
      ),
      tips: (json['tips'] as List<dynamic>?)?.cast<String>(),
      image: image,
    );
  }

  Recipe copyWith({
    String? name,
    String? description,
    int? numberOfServings,
    double? prepTime,
    double? cookTime,
    double? totalTime,
    RecipeDifficulty? difficulty,
    List<RecipeIngredient>? ingredients,
    List<String>? instructions,
    RecipeNutrition? nutrition,
    List<String>? tips,
    Uint8List? image,
  }) {
    return Recipe(
      name: name ?? this.name,
      description: description ?? this.description,
      numberOfServings: numberOfServings ?? this.numberOfServings,
      prepTime: prepTime ?? this.prepTime,
      cookTime: cookTime ?? this.cookTime,
      totalTime: totalTime ?? this.totalTime,
      difficulty: difficulty ?? this.difficulty,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      nutrition: nutrition ?? this.nutrition,
      tips: tips ?? this.tips,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
    name,
    description,
    numberOfServings,
    prepTime,
    cookTime,
    totalTime,
    difficulty,
    ingredients,
    instructions,
    nutrition,
    tips,
    image,
  ];
}
