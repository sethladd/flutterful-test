import 'package:flutter/material.dart';
import 'package:flutterful/features/graphics/widgets/clipping_example.dart';

class ClippingScreen extends StatelessWidget {
  const ClippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clipping'),
      ),
      body: const ClippingExample(),
    );
  }
}
