import 'package:flutter/material.dart';
import 'dart:math' as math;

class ClippingExample extends StatefulWidget {
  const ClippingExample({super.key});

  @override
  State<ClippingExample> createState() => _ClippingExampleState();
}

class _ClippingExampleState extends State<ClippingExample> {
  var _selectedShape = ClipShape.circle;
  var _radius = 16.0;
  var _waveHeight = 32.0;
  var _waveCount = 3;
  var _showCode = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.blue.withOpacity(0.1),
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: ClipPath(
                      clipper: _ShapeClipper(
                        shape: _selectedShape,
                        radius: _radius,
                        waveHeight: _waveHeight,
                        waveCount: _waveCount,
                      ),
                      child: Image.network(
                        'https://picsum.photos/400',
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shape',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 48,
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (final shape in ClipShape.values)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: IconButton.filled(
                                      isSelected: shape == _selectedShape,
                                      icon: Icon(_getShapeIcon(shape)),
                                      onPressed: () => setState(
                                          () => _selectedShape = shape),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildControls(),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () => setState(() => _showCode = !_showCode),
                        icon: Icon(_showCode ? Icons.code_off : Icons.code),
                        label: Text(_showCode ? 'Hide Code' : 'Show Code'),
                      ),
                      if (_showCode) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                          ),
                          child: SelectableText(
                            _buildCode(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontFamily: 'monospace',
                                ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconData _getShapeIcon(ClipShape shape) {
    switch (shape) {
      case ClipShape.circle:
        return Icons.circle_outlined;
      case ClipShape.roundedRect:
        return Icons.rectangle_outlined;
      case ClipShape.wave:
        return Icons.waves;
      case ClipShape.star:
        return Icons.star_outline;
    }
  }

  Widget _buildControls() {
    switch (_selectedShape) {
      case ClipShape.circle:
        return const SizedBox.shrink();
      case ClipShape.roundedRect:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Corner Radius: ${_radius.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _radius,
              min: 0,
              max: 50,
              onChanged: (value) => setState(() => _radius = value),
            ),
          ],
        );
      case ClipShape.wave:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wave Height: ${_waveHeight.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _waveHeight,
              min: 10,
              max: 100,
              onChanged: (value) => setState(() => _waveHeight = value),
            ),
            const SizedBox(height: 8),
            Text(
              'Wave Count: $_waveCount',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _waveCount.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (value) => setState(() => _waveCount = value.toInt()),
            ),
          ],
        );
      case ClipShape.star:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Points: $_waveCount',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _waveCount.toDouble(),
              min: 3,
              max: 12,
              divisions: 9,
              onChanged: (value) => setState(() => _waveCount = value.toInt()),
            ),
          ],
        );
    }
  }

  String _buildCode() {
    final buffer = StringBuffer();
    buffer.writeln('ClipPath(');
    buffer.writeln('  clipper: CustomClipper<Path>(');
    buffer.writeln('    getClip: (Size size) {');
    buffer.writeln('      final path = Path();');

    switch (_selectedShape) {
      case ClipShape.circle:
        buffer.writeln('''
      return path..addOval(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2,
        ),
      );''');
      case ClipShape.roundedRect:
        buffer.writeln('''
      return path..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(${_radius.toStringAsFixed(1)}),
        ),
      );''');
      case ClipShape.wave:
        buffer.writeln('''
      path.lineTo(0, size.height);
      
      final waveWidth = size.width / $_waveCount;
      var x = 0.0;
      var up = true;

      while (x < size.width) {
        if (up) {
          path.quadraticBezierTo(
            x + waveWidth / 2,
            size.height - ${_waveHeight.toStringAsFixed(1)} * 2,
            x + waveWidth,
            size.height,
          );
        } else {
          path.quadraticBezierTo(
            x + waveWidth / 2,
            size.height + ${_waveHeight.toStringAsFixed(1)},
            x + waveWidth,
            size.height,
          );
        }
        x += waveWidth;
        up = !up;
      }
      
      path.lineTo(size.width, 0);
      return path;''');
      case ClipShape.star:
        buffer.writeln('''
      final center = Offset(size.width / 2, size.height / 2);
      final radius = size.width / 2;
      final innerRadius = radius * 0.4;

      for (var i = 0; i < $_waveCount * 2; i++) {
        final r = i.isEven ? radius : innerRadius;
        final angle = i * math.pi / $_waveCount - math.pi / 2;
        final x = center.dx + math.cos(angle) * r;
        final y = center.dy + math.sin(angle) * r;
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      return path..close();''');
    }

    buffer.writeln('    },');
    buffer.writeln('  ),');
    buffer.writeln('  child: child,');
    buffer.writeln(')');

    return buffer.toString();
  }
}

enum ClipShape {
  circle,
  roundedRect,
  wave,
  star,
}

class _ShapeClipper extends CustomClipper<Path> {
  final ClipShape shape;
  final double radius;
  final double waveHeight;
  final int waveCount;

  const _ShapeClipper({
    required this.shape,
    required this.radius,
    required this.waveHeight,
    required this.waveCount,
  });

  @override
  Path getClip(Size size) {
    switch (shape) {
      case ClipShape.circle:
        return Path()
          ..addOval(Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: math.min(size.width, size.height) / 2,
          ));
      case ClipShape.roundedRect:
        return Path()
          ..addRRect(RRect.fromRectAndRadius(
            Offset.zero & size,
            Radius.circular(radius),
          ));
      case ClipShape.wave:
        final path = Path();
        path.lineTo(0, size.height);

        final waveWidth = size.width / waveCount;
        var x = 0.0;
        var up = true;

        while (x < size.width) {
          if (up) {
            path.quadraticBezierTo(
              x + waveWidth / 2,
              size.height - waveHeight * 2,
              x + waveWidth,
              size.height,
            );
          } else {
            path.quadraticBezierTo(
              x + waveWidth / 2,
              size.height + waveHeight,
              x + waveWidth,
              size.height,
            );
          }
          x += waveWidth;
          up = !up;
        }

        path.lineTo(size.width, 0);
        return path;
      case ClipShape.star:
        final path = Path();
        final center = Offset(size.width / 2, size.height / 2);
        final radius = math.min(size.width, size.height) / 2;
        final innerRadius = radius * 0.4;

        for (var i = 0; i < waveCount * 2; i++) {
          final r = i.isEven ? radius : innerRadius;
          final angle = i * math.pi / waveCount - math.pi / 2;
          final x = center.dx + math.cos(angle) * r;
          final y = center.dy + math.sin(angle) * r;
          if (i == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }
        return path..close();
    }
  }

  @override
  bool shouldReclip(_ShapeClipper oldClipper) {
    return shape != oldClipper.shape ||
        radius != oldClipper.radius ||
        waveHeight != oldClipper.waveHeight ||
        waveCount != oldClipper.waveCount;
  }
}
