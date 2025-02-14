// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
