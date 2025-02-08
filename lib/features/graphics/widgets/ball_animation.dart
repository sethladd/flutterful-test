import 'package:flutter/material.dart';

class BallAnimation extends StatelessWidget {
  final Animation<double> animation;

  const BallAnimation({
    super.key,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _BallPainter(
            position: animation.value,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}

class _BallPainter extends CustomPainter {
  final double position;
  final Color color;

  const _BallPainter({
    required this.position,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw path line
    final pathPaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(size.width * 0.1, size.height / 2),
      Offset(size.width * 0.9, size.height / 2),
      pathPaint,
    );

    // Draw ball
    final ballRadius = size.height * 0.05;
    final x = size.width * 0.1 + (size.width * 0.8 * position);
    final y = size.height / 2;

    canvas.drawCircle(
      Offset(x, y),
      ballRadius,
      paint,
    );
  }

  @override
  bool shouldRepaint(_BallPainter oldDelegate) {
    return position != oldDelegate.position || color != oldDelegate.color;
  }
}
