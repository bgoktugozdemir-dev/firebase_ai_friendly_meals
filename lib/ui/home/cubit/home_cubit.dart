import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:firebase_ai_friendly_meals/data/model/recipe.dart';
import 'package:firebase_ai_friendly_meals/data/repository/ai_repository.dart';
import 'package:firebase_ai_friendly_meals/injection.dart';
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
      ),
    );
  }

  void onNotesChanged(String notes) {
    emit(
      state.copyWith(
        notes: notes,
      ),
    );
  }

  void onImageSelected(Uint8List image) {
    emit(
      state.copyWith(
        selectedImage: image,
      ),
    );
  }

  Future<void> onGenerateIngredients() async {
    if (state.selectedImage == null) {
      throw Exception('No image selected');
    }

    emit(
      state.copyWith(
        status: HomeViewState.loading,
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
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeViewState.failure,
        ),
      );
    }
  }

  Future<void> onGenerateRecipe() async {
    if (state.ingredients.isEmpty) {
      throw Exception('No ingredients provided');
    }

    emit(
      HomeState(
        ingredients: state.ingredients,
        notes: state.notes,
        selectedImage: state.selectedImage,
        status: HomeViewState.loading,
      ),
    );

    try {
      final [
        String recipeDescription,
        Uint8List recipeImage,
      ] = await Future.wait<dynamic>([
        _aiRepository.generateRecipe(
          state.ingredients,
          state.notes,
        ),
        _aiRepository.generateRecipeImage(
          state.ingredients,
        ),
      ]);

      final recipe = Recipe(
        description: recipeDescription,
        image: recipeImage,
      );
      emit(
        state.copyWith(
          recipe: recipe,
          status: HomeViewState.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeViewState.failure,
        ),
      );
    }
  }
}
