// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
