import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:injectable/injectable.dart';

@injectable
class AIRemoteDataSource {
  final GenerativeModel _generativeModel;
  final ImagenModel _imagenModel;

  AIRemoteDataSource({
    required GenerativeModel generativeModel,
    required ImagenModel imagenModel,
  }) : _generativeModel = generativeModel,
       _imagenModel = imagenModel;

  Future<String> generateIngredients(Uint8List image) async {
    const prompt =
        "Please analyze this image and list all visible food ingredients. "
        "Format the response as a comma-separated list of ingredients. "
        "Be specific with measurements where possible, "
        "but focus on identifying the ingredients accurately.";

    final response = await _generativeModel.generateContent([
      Content.multi(
        [
          InlineDataPart('image/png', image),
          TextPart(prompt),
        ],
      ),
    ]);

    if (response.text == null) {
      throw Exception('Failed to generate ingredients');
    }

    return response.text!;
  }

  Future<String> generateRecipe(String ingredients, String notes) async {
    String prompt =
        "Based on this ingredients list: $ingredients, please give me one recipe.";
    if (notes.isNotEmpty) {
      prompt += " Please take in consideration these notes: $notes.";
    }

    final response = await _generativeModel.generateContent([
      Content.text(prompt),
    ]);

    if (response.text == null) {
      throw Exception('Failed to generate recipe');
    }

    return response.text!;
  }

  Future<Uint8List> generateRecipeImage(String recipe) async {
    final prompt =
        "A professional food photography shot of this recipe: $recipe. "
        "Style: High-end food photography, restaurant-quality plating, soft natural "
        "lighting, on a clean background, showing the complete plated dish.";

    final imageResponse = await _imagenModel.generateImages(prompt);
    final images = imageResponse.images;

    if (images.isEmpty) {
      throw Exception('Failed to generate recipe image');
    }

    return images.first.bytesBase64Encoded;
  }
}

@module
abstract class FirebaseModule {
  /// You can find the models here: https://ai.google.dev/gemini-api/docs/models

  @singleton
  GenerativeModel provideGenerativeModel() {
    const model = 'gemini-2.0-flash';

    return FirebaseAI.googleAI().generativeModel(
      model: model,
    );
  }

  @singleton
  ImagenModel provideImagenModel() {
    const model = 'imagen-3.0-generate-002';

    final generationConfig = ImagenGenerationConfig(
      numberOfImages: 1,
      aspectRatio: ImagenAspectRatio.square1x1,
      imageFormat: ImagenFormat.png(),
    );

    final safetySettings = ImagenSafetySettings(
      ImagenSafetyFilterLevel.blockLowAndAbove,
      ImagenPersonFilterLevel.blockAll,
    );

    return FirebaseAI.googleAI().imagenModel(
      model: model,
      generationConfig: generationConfig,
      safetySettings: safetySettings,
    );
  }
}
