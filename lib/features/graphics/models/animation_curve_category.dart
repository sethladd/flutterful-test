// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutterful/features/graphics/models/animation_curve_data.dart';

class AnimationCurveCategory {
  final String name;
  final String description;
  final IconData icon;
  final List<AnimationCurveData> curves;

  const AnimationCurveCategory({
    required this.name,
    required this.description,
    required this.icon,
    required this.curves,
  });
}
