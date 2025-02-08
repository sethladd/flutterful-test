import 'package:flutter/material.dart';
import 'package:flutterful/features/graphics/widgets/animation_curves_example.dart';

class AnimationCurvesScreen extends StatelessWidget {
  const AnimationCurvesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Curves'),
      ),
      body: const AnimationCurvesExample(),
    );
  }
}
