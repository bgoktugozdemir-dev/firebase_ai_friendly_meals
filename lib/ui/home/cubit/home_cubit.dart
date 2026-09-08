import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_ai_friendly_meals/core/exceptions/ai_exceptions.dart';
import 'package:firebase_ai_friendly_meals/data/model/recipe.dart';
import 'package:firebase_ai_friendly_meals/data/repository/ai_repository.dart';
import 'package:firebase_ai_friendly_meals/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    AIRepository? aiRepository,
  }) : _aiRepository = aiRepository ?? getIt<AIRepository>(),
       super(const HomeState());

  final AIRepository _aiRepository;

  void onIngredientsChanged(String ingredients) {
    emit(
      state.copyWith(
        ingredients: ingredients,
        errorMessage: () => null,
      ),
    );
  }

  void onNotesChanged(String notes) {
    emit(
      state.copyWith(
        notes: notes,
        errorMessage: () => null,
      ),
    );
  }

  void onImageSelected(Uint8List image) {
    emit(
      state.copyWith(
        selectedImage: () => image,
        errorMessage: () => null,
      ),
    );
  }

  Future<void> onGenerateIngredients() async {
    if (state.selectedImage == null) {
      return;
    }

    emit(
      state.copyWith(
        status: HomeViewState.loading,
        errorMessage: () => null,
      ),
    );

    try {
      final ingredients = await _aiRepository.generateIngredients(
        state.selectedImage!,
      );

      emit(
        state.copyWith(
          ingredients: ingredients,
          status: HomeViewState.success,
          errorMessage: () => null,
        ),
      );
    } on AIException catch (e) {
      emit(
        state.copyWith(
          status: HomeViewState.failure,
          errorMessage: () => _getErrorMessage(e),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeViewState.failure,
          errorMessage: () => 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }

  Future<void> onGenerateRecipe() async {
    if (state.ingredients.trim().isEmpty) {
      emit(
        state.copyWith(
          status: HomeViewState.failure,
          errorMessage: () => 'Please add some ingredients first',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: HomeViewState.loading,
        errorMessage: () => null,
      ),
    );

    try {
      final recipeJson = await _aiRepository.generateRecipe(
        state.ingredients,
        state.notes,
      );

      final recipeImage = await _aiRepository.generateRecipeImage(recipeJson);
      emit(
        state.copyWith(
          recipe: () => Recipe.fromJson(
            jsonDecode(recipeJson),
            image: recipeImage,
          ),
          status: HomeViewState.success,
          errorMessage: () => null,
        ),
      );
    } on AIException catch (e) {
      emit(
        state.copyWith(
          status: HomeViewState.failure,
          errorMessage: () => _getErrorMessage(e),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeViewState.failure,
          errorMessage: () => 'An unexpected error occurred. Please try again.',
        ),
      );
      return;
    }
  }

  String _getErrorMessage(AIException exception) {
    return switch (exception) {
      ValidationException _ => exception.message,
      ImageAnalysisException _ =>
        'Could not analyze the image. Please try with a clearer photo.',
      AIGenerationException _ => exception.message,
      NetworkException _ =>
        'Network error. Please check your connection and try again.',
    };
  }
}
