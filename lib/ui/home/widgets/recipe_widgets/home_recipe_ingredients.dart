import 'package:firebase_ai_friendly_meals/core/utils/compact_num.dart';
import 'package:firebase_ai_friendly_meals/core/widgets/titled_list.dart';
import 'package:firebase_ai_friendly_meals/data/model/recipe_ingredient.dart';
import 'package:flutter/material.dart';

class HomeRecipeIngredients extends StatelessWidget {
  const HomeRecipeIngredients({required this.ingredients, super.key});

  final List<RecipeIngredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return TitledList(
      title: 'Ingredients',
      marker: TitledListMarker.bullet,
      items: [
        for (final ingredient in ingredients) _IngredientLine(ingredient),
      ],
    );
  }
}

class _IngredientLine extends StatelessWidget {
  const _IngredientLine(this.ingredient);

  final RecipeIngredient ingredient;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyMedium;

    return Text.rich(
      TextSpan(
        style: defaultStyle,
        children: [
          TextSpan(
            text:
                '${ingredient.quantity.toCompactString()} ${ingredient.unit.displayName} ',
            style: defaultStyle?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: ingredient.name),
        ],
      ),
    );
  }
}
