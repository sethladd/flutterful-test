// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class CurveGraph extends StatelessWidget {
  final Curve curve;
  final Color color;

  const CurveGraph({
    super.key,
    required this.curve,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CurveGraphPainter(
        curve: curve,
        color: color,
      ),
    );
  }
}

class _CurveGraphPainter extends CustomPainter {
  final Curve curve;
  final Color color;

  const _CurveGraphPainter({
    required this.curve,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw grid
    final gridPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw grid lines
    for (var i = 0; i <= 4; i++) {
      final x = size.width * (i / 4);
      final y = size.height * (i / 4);

      // Vertical lines
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );

      // Horizontal lines
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Draw axes
    final axesPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // X-axis
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      axesPaint,
    );

    // Y-axis
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, 0),
      axesPaint,
    );

    // Draw curve
    final path = Path();
    path.moveTo(0, size.height);

    for (var i = 0; i <= 100; i++) {
      final x = i / 100;
      final y = curve.transform(x);
      path.lineTo(
        x * size.width,
        size.height - (y * size.height),
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CurveGraphPainter oldDelegate) {
    return curve != oldDelegate.curve || color != oldDelegate.color;
  }
}
