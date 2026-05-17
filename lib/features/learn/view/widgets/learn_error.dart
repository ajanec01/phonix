import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class LearnError extends StatelessWidget {
  const LearnError({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          backgroundColor: AppColors.surfaceContainerLow,
          surfaceTintColor: Colors.transparent,
          title: const Text('Learn'),
        ),
        SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
