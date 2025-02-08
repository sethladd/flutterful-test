import 'package:flutter/material.dart';
import 'package:flutterful/features/graphics/widgets/transformations_example.dart';

class TransformationsScreen extends StatelessWidget {
  const TransformationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transformations'),
      ),
      body: const TransformationsExample(),
    );
  }
}
