import 'package:flutter/material.dart';
import 'dart:math' as math;

class TransformationsExample extends StatefulWidget {
  const TransformationsExample({super.key});

  @override
  State<TransformationsExample> createState() => _TransformationsExampleState();
}

class _TransformationsExampleState extends State<TransformationsExample> {
  var _selectedType = TransformType.translate;
  var _translateX = 0.0;
  var _translateY = 0.0;
  var _rotation = 0.0;
  var _scale = 1.0;
  var _skewX = 0.0;
  var _skewY = 0.0;
  var _perspective = 0.0;
  var _showCode = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue.withOpacity(0.1),
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Transform(
                  transform: _buildTransformMatrix(),
                  alignment: Alignment.center,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.flutter_dash,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transform Type',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SegmentedButton<TransformType>(
                  segments: const [
                    ButtonSegment(
                      value: TransformType.translate,
                      icon: Icon(Icons.open_with),
                      label: Text('Translate'),
                    ),
                    ButtonSegment(
                      value: TransformType.rotate,
                      icon: Icon(Icons.rotate_right),
                      label: Text('Rotate'),
                    ),
                    ButtonSegment(
                      value: TransformType.scale,
                      icon: Icon(Icons.zoom_in),
                      label: Text('Scale'),
                    ),
                    ButtonSegment(
                      value: TransformType.skew,
                      icon: Icon(Icons.transform),
                      label: Text('Skew'),
                    ),
                    ButtonSegment(
                      value: TransformType.perspective,
                      icon: Icon(Icons.view_in_ar),
                      label: Text('Perspective'),
                    ),
                  ],
                  selected: {_selectedType},
                  onSelectionChanged: (selected) {
                    setState(() => _selectedType = selected.first);
                  },
                ),
                const SizedBox(height: 16),
                _buildControls(),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _resetTransform,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset Transform'),
                ),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
    );
  }

  Matrix4 _buildTransformMatrix() {
    final matrix = Matrix4.identity()
      ..translate(_translateX, _translateY)
      ..rotateZ(_rotation * math.pi / 180)
      ..scale(_scale);

    // Apply skew
    matrix.setEntry(0, 1, _skewX);
    matrix.setEntry(1, 0, _skewY);

    // Apply perspective
    if (_perspective != 0) {
      const depth = 1000.0;
      matrix.setEntry(3, 2, _perspective / depth);
      matrix.setEntry(2, 3, -1.0);
      matrix.setEntry(3, 3, 1.0 + _perspective / depth);
    }

    return matrix;
  }

  Widget _buildControls() {
    switch (_selectedType) {
      case TransformType.translate:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'X: ${_translateX.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _translateX,
              min: -100,
              max: 100,
              onChanged: (value) => setState(() => _translateX = value),
            ),
            const SizedBox(height: 8),
            Text(
              'Y: ${_translateY.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _translateY,
              min: -100,
              max: 100,
              onChanged: (value) => setState(() => _translateY = value),
            ),
          ],
        );
      case TransformType.rotate:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Angle: ${_rotation.toStringAsFixed(0)}°',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _rotation,
              min: -180,
              max: 180,
              onChanged: (value) => setState(() => _rotation = value),
            ),
          ],
        );
      case TransformType.scale:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scale: ${_scale.toStringAsFixed(1)}x',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _scale,
              min: 0.5,
              max: 2.0,
              onChanged: (value) => setState(() => _scale = value),
            ),
          ],
        );
      case TransformType.skew:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skew X: ${_skewX.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _skewX,
              min: -1,
              max: 1,
              onChanged: (value) => setState(() => _skewX = value),
            ),
            const SizedBox(height: 8),
            Text(
              'Skew Y: ${_skewY.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _skewY,
              min: -1,
              max: 1,
              onChanged: (value) => setState(() => _skewY = value),
            ),
          ],
        );
      case TransformType.perspective:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Perspective: ${_perspective.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _perspective,
              min: -0.01,
              max: 0.01,
              onChanged: (value) => setState(() => _perspective = value),
            ),
          ],
        );
    }
  }

  String _buildCode() {
    final buffer = StringBuffer();
    buffer.writeln('Transform(');
    buffer.writeln('  transform: Matrix4.identity()');

    switch (_selectedType) {
      case TransformType.translate:
        buffer.writeln(
            '    ..translate(${_translateX.toStringAsFixed(1)}, ${_translateY.toStringAsFixed(1)})');
      case TransformType.rotate:
        buffer.writeln(
            '    ..rotateZ(${_rotation.toStringAsFixed(1)} * pi / 180)');
      case TransformType.scale:
        buffer.writeln('    ..scale(${_scale.toStringAsFixed(2)})');
      case TransformType.skew:
        buffer.writeln('''
    // Apply skew
    ..setEntry(0, 1, ${_skewX.toStringAsFixed(2)})
    ..setEntry(1, 0, ${_skewY.toStringAsFixed(2)})''');
      case TransformType.perspective:
        buffer.writeln('''
    // Apply perspective
    ..setEntry(3, 2, ${_perspective.toStringAsFixed(3)} / 1000.0)
    ..setEntry(2, 3, -1.0)
    ..setEntry(3, 3, ${(1.0 + _perspective / 1000.0).toStringAsFixed(3)})''');
    }

    buffer.writeln('  alignment: Alignment.center,');
    buffer.writeln('  child: child,');
    buffer.writeln(')');

    return buffer.toString();
  }

  void _resetTransform() {
    setState(() {
      _translateX = 0;
      _translateY = 0;
      _rotation = 0;
      _scale = 1;
      _skewX = 0;
      _skewY = 0;
      _perspective = 0;
    });
  }
}

enum TransformType {
  translate,
  rotate,
  scale,
  skew,
  perspective,
}
