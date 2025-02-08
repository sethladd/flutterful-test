import 'package:flutter/material.dart';
import 'package:flutterful/features/widgets/widgets_screen.dart';
import 'package:flutterful/features/graphics/graphics_screen.dart';
import 'package:flutterful/features/colors/colors_screen.dart';
import 'package:flutterful/features/search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutterful'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _CategoryCard(
            title: 'Widgets',
            description: 'Explore Flutter widgets by category',
            icon: Icons.widgets,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WidgetsScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _CategoryCard(
            title: 'Graphics & Animations',
            description: 'Learn about Flutter graphics capabilities',
            icon: Icons.animation,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GraphicsScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _CategoryCard(
            title: 'Colors',
            description: 'Explore color models and creation',
            icon: Icons.color_lens,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ColorsScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 48),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
