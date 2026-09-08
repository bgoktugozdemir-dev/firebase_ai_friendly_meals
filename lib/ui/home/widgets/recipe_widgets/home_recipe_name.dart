import 'package:flutter/material.dart';

class HomeRecipeName extends StatelessWidget {
  const HomeRecipeName({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name, style: Theme.of(context).textTheme.headlineSmall);
  }
}
