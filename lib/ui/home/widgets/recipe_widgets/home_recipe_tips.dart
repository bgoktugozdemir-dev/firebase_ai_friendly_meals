import 'package:firebase_ai_friendly_meals/core/widgets/titled_list.dart';
import 'package:flutter/material.dart';

class HomeRecipeTips extends StatelessWidget {
  const HomeRecipeTips({required this.tips, super.key});

  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    return TitledList.text(
      title: 'Tips',
      marker: TitledListMarker.numbered,
      values: tips,
    );
  }
}
