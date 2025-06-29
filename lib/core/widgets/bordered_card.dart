import 'package:firebase_ai_friendly_meals/core/theme/colors.dart';
import 'package:firebase_ai_friendly_meals/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class BorderedCard extends StatelessWidget {
  const BorderedCard({
    required this.child,
    this.isLoading = false,
    super.key,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 96,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.mediumFirebaseYellow,
          border: Border.all(
            color: AppColors.darkFirebaseYellow,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),

            if (isLoading) const _LoadingOverlay(),
          ],
        ),
      ),
    );
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const LoadingIndicator(),
      ),
    );
  }
}
