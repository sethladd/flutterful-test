import 'package:flutter/material.dart';
import 'dart:math' as math;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: _buildGradient(),
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
            ],
          ),
        ),
      ],
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
