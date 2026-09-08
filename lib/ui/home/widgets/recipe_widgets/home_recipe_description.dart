import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class HomeRecipeDescription extends StatelessWidget {
  const HomeRecipeDescription({required this.description, super.key});

  final String description;

  @override
  Widget build(BuildContext context) {
    return GptMarkdown(description);
  }
}
