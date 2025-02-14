// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutterful/features/graphics/widgets/source_code_view.dart';

class ShadowsExample extends StatefulWidget {
  const ShadowsExample({super.key});

  @override
  State<ShadowsExample> createState() => _ShadowsExampleState();
}

class _ShadowsExampleState extends State<ShadowsExample> {
  var _offsetX = 0.0;
  var _offsetY = 4.0;
  var _blurRadius = 8.0;
  var _spreadRadius = 0.0;
  var _color = Colors.black;
  var _opacity = 0.25;

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
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(_offsetX, _offsetY),
                      blurRadius: _blurRadius,
                      spreadRadius: _spreadRadius,
                      color: _color.withOpacity(_opacity),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.flutter_dash,
                    size: 100,
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
                  'Offset X: ${_offsetX.toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Slider(
                  value: _offsetX,
                  min: -50,
                  max: 50,
                  onChanged: (value) => setState(() => _offsetX = value),
                ),
                const SizedBox(height: 16),
                Text(
                  'Offset Y: ${_offsetY.toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Slider(
                  value: _offsetY,
                  min: -50,
                  max: 50,
                  onChanged: (value) => setState(() => _offsetY = value),
                ),
                const SizedBox(height: 16),
                Text(
                  'Blur Radius: ${_blurRadius.toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Slider(
                  value: _blurRadius,
                  min: 0,
                  max: 50,
                  onChanged: (value) => setState(() => _blurRadius = value),
                ),
                const SizedBox(height: 16),
                Text(
                  'Spread Radius: ${_spreadRadius.toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Slider(
                  value: _spreadRadius,
                  min: -25,
                  max: 25,
                  onChanged: (value) => setState(() => _spreadRadius = value),
                ),
                const SizedBox(height: 16),
                Text(
                  'Opacity: ${(_opacity * 100).toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Slider(
                  value: _opacity,
                  min: 0,
                  max: 1,
                  onChanged: (value) => setState(() => _opacity = value),
                ),
                const SizedBox(height: 16),
                Text(
                  'Color',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final color in [
                        Colors.black,
                        Colors.blue,
                        Colors.red,
                        Colors.green,
                        Colors.purple,
                        Colors.orange,
                      ])
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () => setState(() => _color = color),
                            child: Container(
                              width: 42,
                              height: 42,
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
                const SizedBox(height: 16),
                SourceCodeView(sourceCode: _buildCode()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildCode() {
    final colorString = switch (_color) {
      Colors.black => 'Colors.black',
      Colors.blue => 'Colors.blue',
      Colors.red => 'Colors.red',
      Colors.green => 'Colors.green',
      Colors.purple => 'Colors.purple',
      Colors.orange => 'Colors.orange',
      _ => 'Colors.black',
    };

    return '''Container(
  width: 200,
  height: 200,
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        offset: Offset(${_offsetX.toStringAsFixed(1)}, ${_offsetY.toStringAsFixed(1)}),
        blurRadius: ${_blurRadius.toStringAsFixed(1)},
        spreadRadius: ${_spreadRadius.toStringAsFixed(1)},
        color: $colorString.withOpacity(${_opacity.toStringAsFixed(2)}),
      ),
    ],
  ),
  child: const Center(
    child: Icon(
      Icons.flutter_dash,
      size: 100,
    ),
  ),
)''';
  }
}
