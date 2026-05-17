import 'package:flutter/material.dart';
class LearnScrollView extends StatelessWidget {
  const LearnScrollView({super.key, required this.slivers});
  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: const Text('Learn'),
        ),
        ...slivers,
      ],
    );
  }
}
