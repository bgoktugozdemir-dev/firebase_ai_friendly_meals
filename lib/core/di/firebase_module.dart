import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_ai_friendly_meals/core/di/model_names.dart';
import 'package:firebase_ai_friendly_meals/data/model/recipe_difficulty.dart';
import 'package:firebase_ai_friendly_meals/data/model/recipe_ingredient_unit.dart';
import 'package:injectable/injectable.dart';

/// Registers the Firebase AI dependencies.
///
/// You can find the models here: https://ai.google.dev/gemini-api/docs/models
@module
abstract class FirebaseModule {
  /// The Firebase AI entry point, shared by every model below.
  ///
  /// Registering it makes it injectable, so each model provider receives the
  /// same instance instead of building its own.
  @singleton
  FirebaseAI get firebaseAI => FirebaseAI.googleAI();

  /// Writes a recipe as structured JSON from an ingredients list.
  @singleton
  @Named(ModelNames.recipeText)
  GenerativeModel provideRecipeTextModel(FirebaseAI firebaseAI) {
    const model = 'gemini-3.5-flash-lite';

    return firebaseAI.generativeModel(
      model: model,
      generationConfig: _recipeGenerationConfig,
    );
  }

  /// Reads a photo of ingredients and lists them as plain text.
  ///
  /// This model has no recipe JSON schema, so the response can stay a
  /// comma-separated list for the ingredients field.
  @singleton
  @Named(ModelNames.imageToIngredients)
  GenerativeModel provideImageToIngredientsModel(FirebaseAI firebaseAI) {
    const model = 'gemini-3.7-flash';

    return firebaseAI.generativeModel(model: model);
  }

  /// Turns a recipe description into a plated-dish photo.
  @singleton
  @Named(ModelNames.recipeImage)
  GenerativeModel provideRecipeImageModel(FirebaseAI firebaseAI) {
    const model = 'gemini-3.1-flash-lite-image';

    final generationConfig = GenerationConfig(
      responseModalities: [ResponseModalities.image],

      /// You can check [here](https://ai.google.dev/gemini-api/docs/image-generation#optional_configurations) for more info about image configurations.
      imageConfig: const ImageConfig(
        aspectRatio: ImageAspectRatio.square1x1, // Default: 1x1
        imageSize: ImageSize.size1K, // Default: 1K
      ),
    );

    return firebaseAI.generativeModel(
      model: model,
      generationConfig: generationConfig,
    );
  }

  GenerationConfig get _recipeGenerationConfig => GenerationConfig(
    responseMimeType: 'application/json',
    responseSchema: Schema.object(
      properties: {
        "name": Schema.string(
          description: 'The name of the recipe.',
        ),
        "description": Schema.string(
          description:
              'The description of the recipe. Give a detailed description of the recipe in markdown format.',
        ),
        "numberOfServings": Schema.number(
          description: 'The number of servings the recipe makes.',
          minimum: 1,
        ),
        "prepTime": Schema.number(
          description: 'The time it takes to prepare the recipe in minutes.',
        ),
        "cookTime": Schema.number(
          description: 'The time it takes to cook the recipe in minutes.',
        ),
        "totalTime": Schema.number(
          description:
              'The total time it takes to prepare and cook the recipe in minutes.',
        ),
        "difficulty": Schema.enumString(
          enumValues: RecipeDifficulty.allValues,
          description: 'The difficulty of the recipe.',
        ),
        "ingredients": Schema.array(
          items: Schema.object(
            properties: {
              "name": Schema.string(
                description: 'The name of the ingredient.',
              ),
              "quantity": Schema.number(
                description: 'The quantity of the ingredient.',
                minimum: 0,
              ),
              "unit": Schema.enumString(
                enumValues: RecipeIngredientUnit.allValues,
                description:
                    'The unit of the ingredient. If the ingredient is a liquid, use ml or l. If the ingredient is a solid, use g or kg. If the ingredient is a piece, use pieces.',
              ),
            },
            description: 'The ingredients for the recipe.',
          ),
        ),
        "instructions": Schema.array(
          items: Schema.string(),
          description:
              'The instructions for the recipe. Give step by step instructions for the recipe.',
        ),
        "nutrition": Schema.object(
          properties: {
            "calories": Schema.number(
              description: 'The calories of the recipe per serving in kcal.',
              minimum: 0,
            ),
            "protein": Schema.number(
              description: 'The protein of the recipe per serving in grams.',
              minimum: 0,
            ),
            "carbohydrates": Schema.number(
              description:
                  'The carbohydrates of the recipe per serving in grams.',
              minimum: 0,
            ),
            "fat": Schema.number(
              description: 'The fat of the recipe per serving in grams.',
              minimum: 0,
            ),
          },
        ),
        "tips": Schema.array(
          items: Schema.string(),
          description:
              'The tips for the recipe. Give tips to make the recipe better and more delicious.',
          nullable: true,
        ),
      },
    ),
  );
}
