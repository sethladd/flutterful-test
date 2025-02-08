import 'package:flutter/material.dart';
import 'package:flutterful/features/graphics/data/animation_curves.dart';
import 'package:flutterful/features/graphics/models/animation_curve_category.dart';
import 'package:flutterful/features/graphics/models/animation_curve_data.dart';
import 'package:flutterful/features/graphics/widgets/ball_animation.dart';
import 'package:flutterful/features/graphics/widgets/curve_graph.dart';
import 'package:flutterful/features/graphics/widgets/canvas_example.dart';
import 'package:flutterful/features/graphics/widgets/transformations_example.dart';
import 'package:flutterful/features/graphics/widgets/gradients_example.dart';

class GraphicsScreen extends StatefulWidget {
  const GraphicsScreen({super.key});

  @override
  State<GraphicsScreen> createState() => _GraphicsScreenState();
}

class _GraphicsScreenState extends State<GraphicsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  AnimationCurveCategory _selectedCategory = animationCurveCategories.first;
  AnimationCurveData _selectedCurve =
      animationCurveCategories.first.curves.first;
  double _duration = 1.0;

  var _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (_duration * 1000).round()),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: _selectedCurve.curve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateCategory(AnimationCurveCategory category) {
    setState(() {
      _selectedCategory = category;
      _selectedCurve = category.curves.first;
      _animation = CurvedAnimation(
        parent: _controller,
        curve: category.curves.first.curve,
      );
    });
  }

  void _updateCurve(AnimationCurveData curve) {
    setState(() {
      _selectedCurve = curve;
      _animation = CurvedAnimation(
        parent: _controller,
        curve: curve.curve,
      );
    });
  }

  void _updateDuration(double duration) {
    setState(() {
      _duration = duration;
      _controller.duration = Duration(milliseconds: (duration * 1000).round());
    });
  }

  void _playAnimation() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Graphics & Animations'),
          bottom: TabBar(
            onTap: (index) => setState(() => _selectedTab = index),
            tabs: const [
              Tab(text: 'Animation Curves'),
              Tab(text: 'Canvas Drawing'),
              Tab(text: 'Transformations'),
              Tab(text: 'Gradients'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Animation Curves Tab
            Column(
              children: [
                // Animation Preview
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.blue.withOpacity(0.1),
                          child: BallAnimation(animation: _animation),
                        ),
                      ),
                      Container(
                        height: 120,
                        padding: const EdgeInsets.all(16),
                        child: CurveGraph(
                          curve: _selectedCurve.curve,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Controls
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Selection
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (final category in animationCurveCategories)
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ChoiceChip(
                                  label: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        category.icon,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(category.name),
                                    ],
                                  ),
                                  selected: category == _selectedCategory,
                                  onSelected: (selected) {
                                    if (selected) _updateCategory(category);
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Curve Selection
                      Text(
                        'Animation Curve',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<AnimationCurveData>(
                        value: _selectedCurve,
                        items: _selectedCategory.curves
                            .map(
                              (curve) => DropdownMenuItem(
                                value: curve,
                                child: Text(curve.name),
                              ),
                            )
                            .toList(),
                        onChanged: (curve) {
                          if (curve != null) _updateCurve(curve);
                        },
                      ),
                      const SizedBox(height: 16),

                      // Duration Control
                      Text(
                        'Duration: ${_duration.toStringAsFixed(1)}s',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Slider(
                        value: _duration,
                        min: 0.5,
                        max: 2.0,
                        divisions: 15,
                        label: '${_duration.toStringAsFixed(1)}s',
                        onChanged: _updateDuration,
                      ),
                      const SizedBox(height: 16),

                      // Play Button
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _playAnimation,
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Play Animation'),
                        ),
                      ),

                      // Category & Curve Description
                      const SizedBox(height: 16),
                      Text(
                        _selectedCategory.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _selectedCurve.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Canvas Drawing Tab
            const CanvasExample(),
            // Transformations Tab
            const TransformationsExample(),
            // Gradients Tab
            const GradientsExample(),
          ],
        ),
      ),
    );
  }
}
