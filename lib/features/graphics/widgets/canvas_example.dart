import 'package:flutter/material.dart';
import 'dart:math';

class CanvasExample extends StatefulWidget {
  const CanvasExample({super.key});

  @override
  State<CanvasExample> createState() => _CanvasExampleState();
}

class _CanvasExampleState extends State<CanvasExample> {
  var _selectedShape = DrawingShape.line;
  var _strokeWidth = 2.0;
  var _color = Colors.blue.shade500;
  var _style = PaintingStyle.stroke;
  final _paths = <DrawingPath>[];
  Offset? _start;
  Offset? _current;

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _start = details.localPosition;
      _current = details.localPosition;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _current = details.localPosition;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_start != null && _current != null) {
      setState(() {
        _paths.add(
          DrawingPath(
            start: _start!,
            end: _current!,
            shape: _selectedShape,
            strokeWidth: _strokeWidth,
            color: _color,
            style: _style,
          ),
        );
        _start = null;
        _current = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: Container(
              color: Colors.white,
              child: CustomPaint(
                painter: _CanvasPainter(
                  paths: _paths,
                  currentStart: _start,
                  currentEnd: _current,
                  currentShape: _selectedShape,
                  currentStrokeWidth: _strokeWidth,
                  currentColor: _color,
                  currentStyle: _style,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shape',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SegmentedButton<DrawingShape>(
                  segments: const [
                    ButtonSegment(
                      value: DrawingShape.line,
                      icon: Icon(Icons.horizontal_rule),
                    ),
                    ButtonSegment(
                      value: DrawingShape.rectangle,
                      icon: Icon(Icons.rectangle_outlined),
                    ),
                    ButtonSegment(
                      value: DrawingShape.circle,
                      icon: Icon(Icons.circle_outlined),
                    ),
                    ButtonSegment(
                      value: DrawingShape.triangle,
                      icon: Icon(Icons.change_history_outlined),
                    ),
                    ButtonSegment(
                      value: DrawingShape.star,
                      icon: Icon(Icons.star_outline),
                    ),
                    ButtonSegment(
                      value: DrawingShape.arrow,
                      icon: Icon(Icons.arrow_right_alt),
                    ),
                    ButtonSegment(
                      value: DrawingShape.path,
                      icon: Icon(Icons.gesture),
                    ),
                  ],
                  selected: {_selectedShape},
                  onSelectionChanged: (selected) {
                    setState(() => _selectedShape = selected.first);
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stroke Width: ${_strokeWidth.toStringAsFixed(1)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Slider(
                          value: _strokeWidth,
                          min: 1,
                          max: 20,
                          onChanged: (value) {
                            setState(() => _strokeWidth = value);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Style',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SegmentedButton<PaintingStyle>(
                        segments: const [
                          ButtonSegment(
                            value: PaintingStyle.stroke,
                            icon: Icon(Icons.radio_button_unchecked),
                          ),
                          ButtonSegment(
                            value: PaintingStyle.fill,
                            icon: Icon(Icons.circle),
                          ),
                        ],
                        selected: {_style},
                        onSelectionChanged: (selected) {
                          setState(() => _style = selected.first);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Color',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.undo),
                    onPressed: _paths.isEmpty
                        ? null
                        : () {
                            setState(() => _paths.removeLast());
                          },
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _paths.isEmpty
                        ? null
                        : () {
                            setState(() => _paths.clear());
                          },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final color in [
                      Colors.black,
                      Colors.red,
                      Colors.orange,
                      Colors.yellow,
                      Colors.green,
                      Colors.blue,
                      Colors.purple,
                    ])
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () => setState(() => _color = color),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _color == color
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey,
                                width: _color == color ? 2 : 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum DrawingShape {
  line,
  rectangle,
  circle,
  triangle,
  star,
  arrow,
  path,
}

class DrawingPath {
  final Offset start;
  final Offset end;
  final DrawingShape shape;
  final double strokeWidth;
  final Color color;
  final PaintingStyle style;

  const DrawingPath({
    required this.start,
    required this.end,
    required this.shape,
    required this.strokeWidth,
    required this.color,
    required this.style,
  });
}

class _CanvasPainter extends CustomPainter {
  final List<DrawingPath> paths;
  final Offset? currentStart;
  final Offset? currentEnd;
  final DrawingShape currentShape;
  final double currentStrokeWidth;
  final Color currentColor;
  final PaintingStyle currentStyle;

  const _CanvasPainter({
    required this.paths,
    required this.currentStart,
    required this.currentEnd,
    required this.currentShape,
    required this.currentStrokeWidth,
    required this.currentColor,
    required this.currentStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw completed paths
    for (final path in paths) {
      final paint = Paint()
        ..color = path.color
        ..strokeWidth = path.strokeWidth
        ..style = path.style;

      _drawShape(canvas, path.start, path.end, path.shape, paint);
    }

    // Draw current path
    if (currentStart != null && currentEnd != null) {
      final paint = Paint()
        ..color = currentColor
        ..strokeWidth = currentStrokeWidth
        ..style = currentStyle;

      _drawShape(canvas, currentStart!, currentEnd!, currentShape, paint);
    }
  }

  void _drawShape(
    Canvas canvas,
    Offset start,
    Offset end,
    DrawingShape shape,
    Paint paint,
  ) {
    switch (shape) {
      case DrawingShape.line:
        canvas.drawLine(start, end, paint);
      case DrawingShape.rectangle:
        canvas.drawRect(Rect.fromPoints(start, end), paint);
      case DrawingShape.circle:
        final center = Offset(
          (start.dx + end.dx) / 2,
          (start.dy + end.dy) / 2,
        );
        final radius = (end - start).distance / 2;
        canvas.drawCircle(center, radius, paint);
      case DrawingShape.triangle:
        final path = Path();
        final midX = (start.dx + end.dx) / 2;
        path.moveTo(midX, start.dy);
        path.lineTo(end.dx, end.dy);
        path.lineTo(start.dx, end.dy);
        path.close();
        canvas.drawPath(path, paint);
      case DrawingShape.star:
        final center = Offset(
          (start.dx + end.dx) / 2,
          (start.dy + end.dy) / 2,
        );
        final radius = (end - start).distance / 2;
        final path = Path();
        final points = 5;
        final innerRadius = radius * 0.4;

        for (var i = 0; i < points * 2; i++) {
          final r = i.isEven ? radius : innerRadius;
          final angle = i * pi / points - pi / 2;
          final x = center.dx + cos(angle) * r;
          final y = center.dy + sin(angle) * r;
          if (i == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }
        path.close();
        canvas.drawPath(path, paint);
      case DrawingShape.arrow:
        final path = Path();
        final vector = end - start;
        final length = vector.distance;
        final direction = vector / length;
        final normal = Offset(-direction.dy, direction.dx);

        // Arrow shaft
        path.moveTo(start.dx, start.dy);
        path.lineTo(end.dx, end.dy);

        // Arrow head
        final headLength = min(length * 0.3, 30.0);
        final headWidth = headLength * 0.6;
        final tip = end;
        final basePoint = end - direction * headLength;
        final leftPoint = basePoint + normal * headWidth / 2;
        final rightPoint = basePoint - normal * headWidth / 2;

        path.moveTo(tip.dx, tip.dy);
        path.lineTo(leftPoint.dx, leftPoint.dy);
        path.lineTo(rightPoint.dx, rightPoint.dy);
        path.close();

        canvas.drawPath(path, paint);
      case DrawingShape.path:
        final path = Path()
          ..moveTo(start.dx, start.dy)
          ..lineTo(end.dx, end.dy);
        canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_CanvasPainter oldDelegate) {
    return paths != oldDelegate.paths ||
        currentStart != oldDelegate.currentStart ||
        currentEnd != oldDelegate.currentEnd ||
        currentShape != oldDelegate.currentShape ||
        currentStrokeWidth != oldDelegate.currentStrokeWidth ||
        currentColor != oldDelegate.currentColor ||
        currentStyle != oldDelegate.currentStyle;
  }
}
