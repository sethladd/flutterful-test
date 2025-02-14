// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
