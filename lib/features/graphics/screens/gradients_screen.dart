import 'package:flutter/material.dart';
import 'package:flutterful/features/graphics/widgets/gradients_example.dart';

class GradientsScreen extends StatelessWidget {
  const GradientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradients'),
      ),
      body: const GradientsExample(),
    );
  }
}
