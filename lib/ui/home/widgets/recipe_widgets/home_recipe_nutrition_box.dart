import 'package:firebase_ai_friendly_meals/core/utils/compact_num.dart';
import 'package:firebase_ai_friendly_meals/core/widgets/bordered_card.dart';
import 'package:firebase_ai_friendly_meals/core/widgets/titled_list.dart';
import 'package:firebase_ai_friendly_meals/data/model/recipe_nutrition.dart';
import 'package:flutter/material.dart';

class HomeRecipeNutritionBox extends StatelessWidget {
  const HomeRecipeNutritionBox({required this.nutrition, super.key});

  final RecipeNutrition nutrition;

  @override
  Widget build(BuildContext context) {
    return BorderedCard(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: TitledList.text(
        title: 'Nutrition',
        description: '(Per serving)',
        values: [
          'Calories: ${nutrition.calories.toCompactString()} kcal',
          'Protein: ${nutrition.protein.toCompactString()} g',
          'Carbs: ${nutrition.carbohydrates.toCompactString()} g',
          'Fat: ${nutrition.fat.toCompactString()} g',
        ],
      ),
    );
  }
}
