import 'package:flutter/material.dart';
import 'package:flutterful/features/graphics/screens/animation_curves_screen.dart';
import 'package:flutterful/features/graphics/screens/canvas_screen.dart';
import 'package:flutterful/features/graphics/screens/transformations_screen.dart';
import 'package:flutterful/features/graphics/screens/gradients_screen.dart';
import 'package:flutterful/features/graphics/screens/clipping_screen.dart';
import 'package:flutterful/features/graphics/screens/shadows_screen.dart';

class GraphicsMenuScreen extends StatelessWidget {
  const GraphicsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphics & Animations'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _MenuCard(
            title: 'Animation Curves',
            description: 'Explore different animation curves and their effects',
            icon: Icons.animation,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AnimationCurvesScreen(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _MenuCard(
            title: 'Canvas Drawing',
            description: 'Draw shapes and paths using the Canvas API',
            icon: Icons.draw,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CanvasScreen(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _MenuCard(
            title: 'Transformations',
            description: 'Apply various transformations to widgets',
            icon: Icons.transform,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TransformationsScreen(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _MenuCard(
            title: 'Gradients',
            description: 'Create and customize different types of gradients',
            icon: Icons.gradient,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const GradientsScreen(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _MenuCard(
            title: 'Clipping',
            description: 'Clip widgets into various shapes and paths',
            icon: Icons.crop,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ClippingScreen(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _MenuCard(
            title: 'Shadows',
            description: 'Add and customize shadow effects',
            icon: Icons.layers,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ShadowsScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
