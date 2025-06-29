part of 'home_cubit.dart';

enum HomeViewState {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == loading;
}

final class HomeState extends Equatable {
  const HomeState({
    this.ingredients = '',
    this.notes = '',
    this.selectedImage,
    this.recipe,
    this.status = HomeViewState.initial,
  });

  final String ingredients;
  final String notes;
  final Uint8List? selectedImage;
  final Recipe? recipe;
  final HomeViewState status;

  HomeState copyWith({
    String? ingredients,
    String? notes,
    Uint8List? selectedImage,
    Recipe? recipe,
    HomeViewState? status,
  }) {
    return HomeState(
      ingredients: ingredients ?? this.ingredients,
      notes: notes ?? this.notes,
      selectedImage: selectedImage ?? this.selectedImage,
      recipe: recipe ?? this.recipe,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    ingredients,
    notes,
    selectedImage,
    recipe,
    status,
  ];
}
