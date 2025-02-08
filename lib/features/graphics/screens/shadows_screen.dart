import 'package:flutter/material.dart';
import 'package:flutterful/features/graphics/widgets/shadows_example.dart';

class ShadowsScreen extends StatelessWidget {
  const ShadowsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shadows'),
      ),
      body: const ShadowsExample(),
    );
  }
}
