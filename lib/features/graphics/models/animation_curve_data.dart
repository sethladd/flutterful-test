import 'package:flutter/material.dart';

class AnimationCurveData {
  final String name;
  final String description;
  final Curve curve;

  const AnimationCurveData({
    required this.name,
    required this.description,
    required this.curve,
  });
}
