import 'package:flutter/material.dart';

class HomeRecipeServings extends StatelessWidget {
  const HomeRecipeServings({required this.numberOfServings, super.key});

  final int numberOfServings;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            numberOfServings,
            (index) => const Icon(Icons.person),
          ),
        ),
        Text('$numberOfServings serving(s)'),
      ],
    );
  }
}
