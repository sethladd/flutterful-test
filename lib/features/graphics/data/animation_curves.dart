// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutterful/features/graphics/models/animation_curve_data.dart';
import 'package:flutterful/features/graphics/models/animation_curve_category.dart';

final animationCurveCategories = [
  AnimationCurveCategory(
    name: 'Basic',
    description: 'Simple, commonly used animation curves',
    icon: Icons.auto_awesome,
    curves: [
      AnimationCurveData(
        name: 'Linear',
        description:
            'The straight-line animation curve, with no acceleration or deceleration.',
        curve: Curves.linear,
      ),
      AnimationCurveData(
        name: 'Ease',
        description:
            'A smooth animation curve that speeds up quickly and slows gradually.',
        curve: Curves.ease,
      ),
      AnimationCurveData(
        name: 'Decelerate',
        description: 'Starts fast and slowly decelerates to a stop.',
        curve: Curves.decelerate,
      ),
    ],
  ),
  AnimationCurveCategory(
    name: 'Standard Ease',
    description: 'Basic easing curves for smooth animations',
    icon: Icons.gesture,
    curves: [
      AnimationCurveData(
        name: 'Ease In',
        description: 'Starts slowly and speeds up towards the end.',
        curve: Curves.easeIn,
      ),
      AnimationCurveData(
        name: 'Ease Out',
        description: 'Starts quickly and slows down towards the end.',
        curve: Curves.easeOut,
      ),
      AnimationCurveData(
        name: 'Ease In Out',
        description: 'Starts and ends slowly but speeds up in the middle.',
        curve: Curves.easeInOut,
      ),
    ],
  ),
  AnimationCurveCategory(
    name: 'Sine',
    description: 'Sinusoidal easing functions',
    icon: Icons.waves,
    curves: [
      AnimationCurveData(
        name: 'Ease In Sine',
        description: 'Sinusoidal easing, gradual acceleration.',
        curve: Curves.easeInSine,
      ),
      AnimationCurveData(
        name: 'Ease Out Sine',
        description: 'Sinusoidal easing, gradual deceleration.',
        curve: Curves.easeOutSine,
      ),
      AnimationCurveData(
        name: 'Ease In Out Sine',
        description: 'Sinusoidal easing, smooth acceleration and deceleration.',
        curve: Curves.easeInOutSine,
      ),
    ],
  ),
  AnimationCurveCategory(
    name: 'Power',
    description: 'Easing functions with different power factors',
    icon: Icons.speed,
    curves: [
      // Quad
      AnimationCurveData(
        name: 'Ease In Quad',
        description: 'Quadratic easing, accelerating from zero velocity.',
        curve: Curves.easeInQuad,
      ),
      AnimationCurveData(
        name: 'Ease Out Quad',
        description: 'Quadratic easing, decelerating to zero velocity.',
        curve: Curves.easeOutQuad,
      ),
      AnimationCurveData(
        name: 'Ease In Out Quad',
        description: 'Quadratic easing, smooth acceleration and deceleration.',
        curve: Curves.easeInOutQuad,
      ),
      // Cubic
      AnimationCurveData(
        name: 'Ease In Cubic',
        description: 'Cubic easing, accelerating from zero velocity.',
        curve: Curves.easeInCubic,
      ),
      AnimationCurveData(
        name: 'Ease Out Cubic',
        description: 'Cubic easing, decelerating to zero velocity.',
        curve: Curves.easeOutCubic,
      ),
      AnimationCurveData(
        name: 'Ease In Out Cubic',
        description: 'Cubic easing, smooth acceleration and deceleration.',
        curve: Curves.easeInOutCubic,
      ),
      // Quart
      AnimationCurveData(
        name: 'Ease In Quart',
        description: 'Quartic easing, accelerating from zero velocity.',
        curve: Curves.easeInQuart,
      ),
      AnimationCurveData(
        name: 'Ease Out Quart',
        description: 'Quartic easing, decelerating to zero velocity.',
        curve: Curves.easeOutQuart,
      ),
      AnimationCurveData(
        name: 'Ease In Out Quart',
        description: 'Quartic easing, smooth acceleration and deceleration.',
        curve: Curves.easeInOutQuart,
      ),
      // Quint
      AnimationCurveData(
        name: 'Ease In Quint',
        description: 'Quintic easing, accelerating from zero velocity.',
        curve: Curves.easeInQuint,
      ),
      AnimationCurveData(
        name: 'Ease Out Quint',
        description: 'Quintic easing, decelerating to zero velocity.',
        curve: Curves.easeOutQuint,
      ),
      AnimationCurveData(
        name: 'Ease In Out Quint',
        description: 'Quintic easing, smooth acceleration and deceleration.',
        curve: Curves.easeInOutQuint,
      ),
    ],
  ),
  AnimationCurveCategory(
    name: 'Exponential',
    description: 'Exponential easing functions',
    icon: Icons.trending_up,
    curves: [
      AnimationCurveData(
        name: 'Ease In Expo',
        description: 'Exponential easing, accelerating from zero velocity.',
        curve: Curves.easeInExpo,
      ),
      AnimationCurveData(
        name: 'Ease Out Expo',
        description: 'Exponential easing, decelerating to zero velocity.',
        curve: Curves.easeOutExpo,
      ),
      AnimationCurveData(
        name: 'Ease In Out Expo',
        description:
            'Exponential easing, smooth acceleration and deceleration.',
        curve: Curves.easeInOutExpo,
      ),
    ],
  ),
  AnimationCurveCategory(
    name: 'Special Effects',
    description: 'Curves with unique motion effects',
    icon: Icons.auto_fix_high,
    curves: [
      AnimationCurveData(
        name: 'Elastic In',
        description: 'Elastic easing, overshooting at the start.',
        curve: Curves.elasticIn,
      ),
      AnimationCurveData(
        name: 'Elastic Out',
        description: 'Elastic easing, overshooting at the end.',
        curve: Curves.elasticOut,
      ),
      AnimationCurveData(
        name: 'Elastic In Out',
        description: 'Elastic easing, overshooting at both ends.',
        curve: Curves.elasticInOut,
      ),
      AnimationCurveData(
        name: 'Bounce In',
        description: 'Bouncing easing, like a ball bouncing at the start.',
        curve: Curves.bounceIn,
      ),
      AnimationCurveData(
        name: 'Bounce Out',
        description: 'Bouncing easing, like a ball bouncing at the end.',
        curve: Curves.bounceOut,
      ),
      AnimationCurveData(
        name: 'Bounce In Out',
        description: 'Bouncing easing at both ends.',
        curve: Curves.bounceInOut,
      ),
    ],
  ),
  AnimationCurveCategory(
    name: 'Misc',
    description: 'Other specialized animation curves',
    icon: Icons.more_horiz,
    curves: [
      AnimationCurveData(
        name: 'Fast Linear to Slow Ease In',
        description:
            'Starts linearly then gradually slows down with an ease-in curve.',
        curve: Curves.fastLinearToSlowEaseIn,
      ),
      AnimationCurveData(
        name: 'Slow Middle',
        description: 'Animation moves slowly in the middle of the curve.',
        curve: Curves.slowMiddle,
      ),
    ],
  ),
];

// Flattened list for backward compatibility
final animationCurves = [
  for (final category in animationCurveCategories) ...category.curves,
];
