import 'package:firebase_ai_friendly_meals/core/widgets/bordered_card.dart';
import 'package:firebase_ai_friendly_meals/core/widgets/titled_list.dart';
import 'package:firebase_ai_friendly_meals/data/model/recipe_difficulty.dart';
import 'package:flutter/material.dart';

class HomeRecipeInfoBox extends StatelessWidget {
  const HomeRecipeInfoBox({
    required this.prepTime,
    required this.cookTime,
    required this.totalTime,
    required this.difficulty,
    super.key,
  });

  final double prepTime;
  final double cookTime;
  final double totalTime;
  final RecipeDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return BorderedCard(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        spacing: 16,
        children: [
          TitledList.text(
            title: 'Time',
            values: [
              'Prep: ${prepTime.toInt()} min',
              'Cook: ${cookTime.toInt()} min',
              'Total: ${totalTime.toInt()} min',
            ],
          ),
          TitledList.text(
            title: 'Difficulty',
            values: [difficulty.displayName],
          ),
        ],
      ),
    );
  }
}
