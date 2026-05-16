import 'package:flutter/material.dart';
import 'app_shell.dart';
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
      home: const AppShell(),
    );
  }
}
