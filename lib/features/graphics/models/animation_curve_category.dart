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
