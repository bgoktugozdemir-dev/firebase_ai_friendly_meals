import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_ai_friendly_meals/core/di/model_names.dart';
import 'package:firebase_ai_friendly_meals/core/exceptions/ai_exceptions.dart';
import 'package:injectable/injectable.dart';

@injectable
class AIRemoteDataSource {
  final GenerativeModel _recipeTextModel;
  final GenerativeModel _imageToIngredientsModel;
  final GenerativeModel _recipeImageModel;

  AIRemoteDataSource({
    @Named(ModelNames.recipeText) required GenerativeModel recipeTextModel,
    @Named(ModelNames.imageToIngredients)
    required GenerativeModel imageToIngredientsModel,
    @Named(ModelNames.recipeImage) required GenerativeModel recipeImageModel,
  }) : _recipeTextModel = recipeTextModel,
       _imageToIngredientsModel = imageToIngredientsModel,
       _recipeImageModel = recipeImageModel;

  Future<String> generateIngredients(Uint8List image) async {
    if (image.isEmpty) {
      throw const ValidationException('Image data is empty');
    }

    const prompt =
        "Please analyze this image and list all visible food ingredients. "
        "Format the response as a comma-separated list of ingredients. "
        "Be specific with measurements where possible, "
        "but focus on identifying the ingredients accurately.";

    try {
      final response = await _imageToIngredientsModel.generateContent([
        Content.multi(
          [
            InlineDataPart('image/png', image),
            const TextPart(prompt),
          ],
        ),
      ]);

      if (response.text == null || response.text!.trim().isEmpty) {
        throw const ImageAnalysisException(
          'Failed to analyze image - no ingredients detected',
        );
      }

      return response.text!;
    } catch (e) {
      if (e is AIException) {
        rethrow;
      }
      throw ImageAnalysisException(
        'Failed to generate ingredients: $e',
      );
    }
  }

  Future<String> generateRecipe(String ingredients, String notes) async {
    if (ingredients.trim().isEmpty) {
      throw const ValidationException('Ingredients list cannot be empty');
    }

    String prompt =
        "Based on this ingredients list: $ingredients, please give me one recipe.";
    if (notes.isNotEmpty) {
      prompt += " Please take into consideration these notes: $notes.";
    }

    try {
      final response = await _recipeTextModel.generateContent([
        Content.text(prompt),
      ]);

      if (response.text == null || response.text!.trim().isEmpty) {
        throw const AIGenerationException(
          'Failed to generate recipe - empty response',
        );
      }

      return response.text!;
    } catch (e) {
      if (e is AIException) {
        rethrow;
      }
      throw AIGenerationException('Failed to generate recipe: $e');
    }
  }

  Future<Uint8List> generateRecipeImage(String recipe) async {
    if (recipe.trim().isEmpty) {
      throw const ValidationException('Recipe description cannot be empty');
    }

    final prompt =
        "A professional food photography shot of this recipe object: $recipe. "
        "Style: High-end food photography, restaurant-quality plating, soft natural "
        "lighting, on a clean background, showing the complete plated dish.";

    try {
      final response = await _recipeImageModel.generateContent([
        Content.text(prompt),
      ]);
      if (response.inlineDataParts.isEmpty) {
        throw const AIGenerationException(
          'Failed to generate recipe image - no images returned',
        );
      }

      return response.inlineDataParts.first.bytes;
    } catch (e) {
      if (e is AIException) {
        rethrow;
      }
      throw AIGenerationException(
        'Failed to generate recipe image: $e',
      );
    }
  }
}
