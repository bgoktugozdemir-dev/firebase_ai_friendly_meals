import 'package:firebase_ai_friendly_meals/core/widgets/titled_list.dart';
import 'package:flutter/material.dart';

class HomeRecipeInstructions extends StatelessWidget {
  const HomeRecipeInstructions({required this.instructions, super.key});

  final List<String> instructions;

  @override
  Widget build(BuildContext context) {
    return TitledList.text(
      title: 'Instructions',
      marker: TitledListMarker.numbered,
      values: instructions,
    );
  }
}
