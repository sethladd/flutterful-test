import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutterful/features/graphics/widgets/source_code_view.dart';

class GradientsExample extends StatefulWidget {
  const GradientsExample({super.key});

  @override
  State<GradientsExample> createState() => _GradientsExampleState();
}

class _GradientsExampleState extends State<GradientsExample> {
  var _selectedType = GradientType.linear;
  var _angle = 0.0;
  var _centerX = 0.5;
  var _centerY = 0.5;
  var _radius = 0.5;
  var _colors = const [Colors.blue, Colors.green];
  var _opacities = [1.0, 1.0];
  var _stops = const [0.0, 1.0];
  var _tileMode = TileMode.clamp;
  var _showCode = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.blue.withOpacity(0.1),
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  gradient: _buildGradient(),
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
                  'Gradient Type',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SegmentedButton<GradientType>(
                  segments: const [
                    ButtonSegment(
                      value: GradientType.linear,
                      icon: Icon(Icons.line_axis),
                      label: Text('Linear'),
                    ),
                    ButtonSegment(
                      value: GradientType.radial,
                      icon: Icon(Icons.radio_button_unchecked),
                      label: Text('Radial'),
                    ),
                    ButtonSegment(
                      value: GradientType.sweep,
                      icon: Icon(Icons.rotate_right),
                      label: Text('Sweep'),
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
                Text(
                  'Colors & Opacity',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final colorSet in _predefinedColorSets)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _colors = colorSet;
                                _opacities = List.filled(colorSet.length, 1.0);
                              });
                            },
                            child: Container(
                              width: 64,
                              height: 32,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: colorSet),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: _colors == colorSet
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey,
                                  width: _colors == colorSet ? 2 : 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                for (var i = 0; i < _colors.length; i++) ...[
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: _colors[i],
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Color ${i + 1} Opacity: ${(_opacities[i] * 100).toStringAsFixed(0)}%',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Slider(
                              value: _opacities[i],
                              min: 0,
                              max: 1,
                              onChanged: (value) {
                                setState(() {
                                  _opacities[i] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (i < _colors.length - 1) const SizedBox(height: 8),
                ],
                const SizedBox(height: 16),
                Text(
                  'Tile Mode',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SegmentedButton<TileMode>(
                  segments: const [
                    ButtonSegment(
                      value: TileMode.clamp,
                      label: Text('Clamp'),
                    ),
                    ButtonSegment(
                      value: TileMode.repeated,
                      label: Text('Repeat'),
                    ),
                    ButtonSegment(
                      value: TileMode.mirror,
                      label: Text('Mirror'),
                    ),
                  ],
                  selected: {_tileMode},
                  onSelectionChanged: (selected) {
                    setState(() => _tileMode = selected.first);
                  },
                ),
                const SizedBox(height: 16),
                SourceCodeView(sourceCode: _buildCode()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    switch (_selectedType) {
      case GradientType.linear:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Angle: ${_angle.toStringAsFixed(0)}°',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _angle,
              min: 0,
              max: 360,
              onChanged: (value) => setState(() => _angle = value),
            ),
          ],
        );
      case GradientType.radial:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Center X: ${_centerX.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _centerX,
              min: 0,
              max: 1,
              onChanged: (value) => setState(() => _centerX = value),
            ),
            const SizedBox(height: 8),
            Text(
              'Center Y: ${_centerY.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _centerY,
              min: 0,
              max: 1,
              onChanged: (value) => setState(() => _centerY = value),
            ),
            const SizedBox(height: 8),
            Text(
              'Radius: ${_radius.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _radius,
              min: 0,
              max: 1,
              onChanged: (value) => setState(() => _radius = value),
            ),
          ],
        );
      case GradientType.sweep:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Center X: ${_centerX.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _centerX,
              min: 0,
              max: 1,
              onChanged: (value) => setState(() => _centerX = value),
            ),
            const SizedBox(height: 8),
            Text(
              'Center Y: ${_centerY.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              value: _centerY,
              min: 0,
              max: 1,
              onChanged: (value) => setState(() => _centerY = value),
            ),
          ],
        );
    }
  }

  Gradient _buildGradient() {
    final colorsWithOpacity = List.generate(
      _colors.length,
      (i) => _colors[i].withOpacity(_opacities[i]),
    );

    switch (_selectedType) {
      case GradientType.linear:
        final angle = _angle * math.pi / 180;
        return LinearGradient(
          colors: colorsWithOpacity,
          stops: _stops,
          tileMode: _tileMode,
          begin: Alignment(math.cos(angle), math.sin(angle)),
          end: Alignment(-math.cos(angle), -math.sin(angle)),
        );
      case GradientType.radial:
        return RadialGradient(
          colors: colorsWithOpacity,
          stops: _stops,
          tileMode: _tileMode,
          center: Alignment(_centerX * 2 - 1, _centerY * 2 - 1),
          radius: _radius,
        );
      case GradientType.sweep:
        return SweepGradient(
          colors: colorsWithOpacity,
          stops: _stops,
          tileMode: _tileMode,
          center: Alignment(_centerX * 2 - 1, _centerY * 2 - 1),
        );
    }
  }

  String _buildCode() {
    final colorStrings = _colors.asMap().entries.map(
      (entry) {
        final color = entry.value;
        final opacity = _opacities[entry.key];
        return switch (color) {
          Colors.blue =>
            'Colors.blue.withOpacity(${opacity.toStringAsFixed(2)})',
          Colors.green =>
            'Colors.green.withOpacity(${opacity.toStringAsFixed(2)})',
          Colors.purple =>
            'Colors.purple.withOpacity(${opacity.toStringAsFixed(2)})',
          Colors.orange =>
            'Colors.orange.withOpacity(${opacity.toStringAsFixed(2)})',
          Colors.red => 'Colors.red.withOpacity(${opacity.toStringAsFixed(2)})',
          Colors.yellow =>
            'Colors.yellow.withOpacity(${opacity.toStringAsFixed(2)})',
          Colors.pink =>
            'Colors.pink.withOpacity(${opacity.toStringAsFixed(2)})',
          _ => 'Colors.blue.withOpacity(${opacity.toStringAsFixed(2)})',
        };
      },
    ).toList();

    final buffer = StringBuffer();
    buffer.writeln('Container(');
    buffer.writeln('  width: double.infinity,');
    buffer.writeln('  height: 300,');
    buffer.writeln('  decoration: BoxDecoration(');
    buffer.writeln('    gradient: ${_selectedType.name}Gradient(');
    buffer.writeln('      colors: [');
    for (final colorString in colorStrings) {
      buffer.writeln('        $colorString,');
    }
    buffer.writeln('      ],');
    buffer.writeln(
        '      stops: ${_stops.map((s) => s.toStringAsFixed(1)).toList()},');
    buffer.writeln('      tileMode: TileMode.${_tileMode.name},');

    switch (_selectedType) {
      case GradientType.linear:
        final angle = _angle * math.pi / 180;
        buffer.writeln(
            '      begin: Alignment(${math.cos(angle).toStringAsFixed(2)}, ${math.sin(angle).toStringAsFixed(2)}),');
        buffer.writeln(
            '      end: Alignment(${(-math.cos(angle)).toStringAsFixed(2)}, ${(-math.sin(angle)).toStringAsFixed(2)}),');
      case GradientType.radial:
        buffer.writeln(
            '      center: Alignment(${(_centerX * 2 - 1).toStringAsFixed(2)}, ${(_centerY * 2 - 1).toStringAsFixed(2)}),');
        buffer.writeln('      radius: ${_radius.toStringAsFixed(2)},');
      case GradientType.sweep:
        buffer.writeln(
            '      center: Alignment(${(_centerX * 2 - 1).toStringAsFixed(2)}, ${(_centerY * 2 - 1).toStringAsFixed(2)}),');
    }

    buffer.writeln('    ),');
    buffer.writeln('  ),');
    buffer.writeln(')');

    return buffer.toString();
  }

  static const _predefinedColorSets = [
    [Colors.blue, Colors.green],
    [Colors.purple, Colors.orange],
    [Colors.red, Colors.yellow],
    [Colors.pink, Colors.blue],
    [Colors.orange, Colors.purple, Colors.blue],
    [Colors.yellow, Colors.red, Colors.purple],
  ];
}

enum GradientType {
  linear,
  radial,
  sweep,
}
