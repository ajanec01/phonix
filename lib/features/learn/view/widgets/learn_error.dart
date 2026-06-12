import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import 'learn_scroll_view.dart';

class LearnError extends StatelessWidget {
  const LearnError({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.onSurfaceVariantDark : AppColors.onSurfaceVariant;
    return LearnScrollView(
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: textColor,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
