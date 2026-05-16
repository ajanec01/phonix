import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PhonixApp());
}

class PhonixApp extends StatelessWidget {
  const PhonixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phonix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const _ThemePreview(),
    );
  }
}

// Temporary preview screen — will be replaced by the real home screen.
class _ThemePreview extends StatelessWidget {
  const _ThemePreview();

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Phonix')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text('Display Large', style: tt.displayLarge),
          Text('Headline Medium', style: tt.headlineMedium),
          Text('Title Large', style: tt.titleLarge),
          Text('Body Large — The ship sailed past the rocks.', style: tt.bodyLarge),
          Text('Label Large', style: tt.labelLarge),
          const SizedBox(height: 32),
          FilledButton(onPressed: () {}, child: const Text('Primary button')),
          const SizedBox(height: 12),
          OutlinedButton(onPressed: () {}, child: const Text('Outlined button')),
          const SizedBox(height: 32),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _PhaseChip(label: 'Phase 1', color: cs.primary),
              _PhaseChip(label: 'Phase 2', color: const Color(0xFFEA580C)),
              _PhaseChip(label: 'Phase 3', color: const Color(0xFF10B981)),
              _PhaseChip(label: 'Phase 4', color: const Color(0xFF3B82F6)),
              _PhaseChip(label: 'Phase 5', color: const Color(0xFF8B5CF6)),
              _PhaseChip(label: 'Phase 6', color: const Color(0xFFEC4899)),
            ],
          ),
        ],
      ),
    );
  }
}

class _PhaseChip extends StatelessWidget {
  const _PhaseChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
