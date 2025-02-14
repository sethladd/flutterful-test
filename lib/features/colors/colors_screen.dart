// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutterful/features/colors/models/color_model.dart';
import 'package:flutterful/features/graphics/widgets/source_code_view.dart';

class ColorsScreen extends StatefulWidget {
  const ColorsScreen({super.key});

  @override
  State<ColorsScreen> createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  var _colorState = const ColorState();

  void _updateColorSpace(ColorSpace colorSpace) {
    if (colorSpace == _colorState.colorSpace) return;

    final currentColor = _colorState.toColor();
    if (colorSpace == ColorSpace.hsv) {
      final hsv = HSVColor.fromColor(currentColor);
      setState(() {
        _colorState = _colorState.copyWith(
          colorSpace: colorSpace,
          hue: hsv.hue,
          saturation: hsv.saturation,
          value: hsv.value,
        );
      });
    } else {
      setState(() {
        _colorState = _colorState.copyWith(
          colorSpace: colorSpace,
          red: currentColor.red,
          green: currentColor.green,
          blue: currentColor.blue,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colors'),
      ),
      body: Column(
        children: [
          // Color Preview
          Container(
            width: double.infinity,
            height: 100,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _colorState.toColor(),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),

          // Color Space Selection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<ColorSpace>(
              segments: const [
                ButtonSegment(
                  value: ColorSpace.hsv,
                  label: Text('HSV'),
                ),
                ButtonSegment(
                  value: ColorSpace.rgb,
                  label: Text('RGB'),
                ),
              ],
              selected: {_colorState.colorSpace},
              onSelectionChanged: (selected) =>
                  _updateColorSpace(selected.first),
            ),
          ),

          // Color Controls
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _colorState.colorSpace == ColorSpace.hsv
                  ? _HSVControls(
                      colorState: _colorState,
                      onChanged: (state) => setState(() => _colorState = state),
                    )
                  : _RGBControls(
                      colorState: _colorState,
                      onChanged: (state) => setState(() => _colorState = state),
                    ),
            ),
          ),

          // Replace existing code display with SourceCodeView
          Padding(
            padding: const EdgeInsets.all(16),
            child: SourceCodeView(
              sourceCode: _colorState.toCode(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HSVControls extends StatelessWidget {
  final ColorState colorState;
  final ValueChanged<ColorState> onChanged;

  const _HSVControls({
    required this.colorState,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hue: ${colorState.hue.toStringAsFixed(1)}°',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Slider(
          value: colorState.hue,
          min: 0,
          max: 360,
          onChanged: (value) => onChanged(colorState.copyWith(hue: value)),
        ),
        const SizedBox(height: 16),
        Text(
          'Saturation: ${(colorState.saturation * 100).toStringAsFixed(0)}%',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Slider(
          value: colorState.saturation,
          min: 0,
          max: 1,
          onChanged: (value) =>
              onChanged(colorState.copyWith(saturation: value)),
        ),
        const SizedBox(height: 16),
        Text(
          'Value: ${(colorState.value * 100).toStringAsFixed(0)}%',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Slider(
          value: colorState.value,
          min: 0,
          max: 1,
          onChanged: (value) => onChanged(colorState.copyWith(value: value)),
        ),
        const SizedBox(height: 16),
        Text(
          'Opacity: ${(colorState.opacity * 100).toStringAsFixed(0)}%',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Slider(
          value: colorState.opacity,
          min: 0,
          max: 1,
          onChanged: (value) => onChanged(colorState.copyWith(opacity: value)),
        ),
      ],
    );
  }
}

class _RGBControls extends StatelessWidget {
  final ColorState colorState;
  final ValueChanged<ColorState> onChanged;

  const _RGBControls({
    required this.colorState,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Red: ${colorState.red}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Slider(
          value: colorState.red.toDouble(),
          min: 0,
          max: 255,
          onChanged: (value) =>
              onChanged(colorState.copyWith(red: value.round())),
        ),
        const SizedBox(height: 16),
        Text(
          'Green: ${colorState.green}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Slider(
          value: colorState.green.toDouble(),
          min: 0,
          max: 255,
          onChanged: (value) =>
              onChanged(colorState.copyWith(green: value.round())),
        ),
        const SizedBox(height: 16),
        Text(
          'Blue: ${colorState.blue}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Slider(
          value: colorState.blue.toDouble(),
          min: 0,
          max: 255,
          onChanged: (value) =>
              onChanged(colorState.copyWith(blue: value.round())),
        ),
        const SizedBox(height: 16),
        Text(
          'Opacity: ${(colorState.opacity * 100).toStringAsFixed(0)}%',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Slider(
          value: colorState.opacity,
          min: 0,
          max: 1,
          onChanged: (value) => onChanged(colorState.copyWith(opacity: value)),
        ),
      ],
    );
  }
}
