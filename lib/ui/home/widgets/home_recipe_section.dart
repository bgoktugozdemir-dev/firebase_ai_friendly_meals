import 'package:firebase_ai_friendly_meals/core/widgets/bordered_card.dart';
import 'package:firebase_ai_friendly_meals/core/widgets/memory_image_builder.dart';
import 'package:firebase_ai_friendly_meals/data/model/recipe.dart';
import 'package:firebase_ai_friendly_meals/ui/home/cubit/home_cubit.dart';
import 'package:firebase_ai_friendly_meals/ui/home/widgets/recipe_widgets/home_recipe_description.dart';
import 'package:firebase_ai_friendly_meals/ui/home/widgets/recipe_widgets/home_recipe_info_box.dart';
import 'package:firebase_ai_friendly_meals/ui/home/widgets/recipe_widgets/home_recipe_ingredients.dart';
import 'package:firebase_ai_friendly_meals/ui/home/widgets/recipe_widgets/home_recipe_instructions.dart';
import 'package:firebase_ai_friendly_meals/ui/home/widgets/recipe_widgets/home_recipe_name.dart';
import 'package:firebase_ai_friendly_meals/ui/home/widgets/recipe_widgets/home_recipe_nutrition_box.dart';
import 'package:firebase_ai_friendly_meals/ui/home/widgets/recipe_widgets/home_recipe_servings.dart';
import 'package:firebase_ai_friendly_meals/ui/home/widgets/recipe_widgets/home_recipe_tips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRecipeSection extends StatelessWidget {
  const HomeRecipeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => previous.recipe != current.recipe,
      builder: (context, state) {
        if (state.recipe == null) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BorderedCard(
            child: Column(
              spacing: 16,
              children: [
                if (state.recipe?.image case final image?)
                  MemoryImageBuilder(imageBytes: image),
                if (state.recipe case final recipe?)
                  _RecipeDescription(recipe: recipe),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RecipeDescription extends StatelessWidget {
  const _RecipeDescription({required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeRecipeName(name: recipe.name),
        HomeRecipeDescription(description: recipe.description),
        HomeRecipeServings(numberOfServings: recipe.numberOfServings),
        IntrinsicHeight(
          child: Row(
            spacing: 4,
            children: [
              Expanded(
                child: HomeRecipeNutritionBox(
                  nutrition: recipe.nutrition,
                ),
              ),
              Expanded(
                child: HomeRecipeInfoBox(
                  prepTime: recipe.prepTime,
                  cookTime: recipe.cookTime,
                  totalTime: recipe.totalTime,
                  difficulty: recipe.difficulty,
                ),
              ),
            ],
          ),
        ),
        HomeRecipeIngredients(ingredients: recipe.ingredients),
        const Divider(),
        HomeRecipeInstructions(instructions: recipe.instructions),
        if (recipe.tips case final tips?) ...[
          const Divider(),
          HomeRecipeTips(tips: tips),
        ],
      ],
    );
  }
}
