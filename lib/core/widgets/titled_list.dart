import 'package:flutter/material.dart';

enum TitledListMarker { none, bullet, numbered }

class TitledList extends StatelessWidget {
  const TitledList({
    required this.title,
    required this.items,
    this.description,
    this.marker = TitledListMarker.none,
    super.key,
  });

  TitledList.text({
    required this.title,
    required List<String> values,
    this.description,
    this.marker = TitledListMarker.none,
    super.key,
  }) : items = [for (final value in values) Text(value)];

  final String title;
  final String? description;
  final List<Widget> items;
  final TitledListMarker marker;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(title, style: textTheme.titleLarge),
            if (description case final description?)
              Text(description, style: textTheme.labelMedium),
          ],
        ),
        Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < items.length; i++)
              _TitledListItem(marker: marker, index: i, child: items[i]),
          ],
        ),
      ],
    );
  }
}

class _TitledListItem extends StatelessWidget {
  const _TitledListItem({
    required this.marker,
    required this.index,
    required this.child,
  });

  final TitledListMarker marker;
  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final prefix = switch (marker) {
      TitledListMarker.none => null,
      TitledListMarker.bullet => '•',
      TitledListMarker.numbered => '${index + 1}.',
    };

    if (prefix == null) {
      return child;
    }

    final textTheme = Theme.of(context).textTheme;
    final prefixStyle = marker == TitledListMarker.numbered
        ? textTheme.titleMedium
        : textTheme.bodyMedium;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(prefix, style: prefixStyle),
        Expanded(child: child),
      ],
    );
  }
}
