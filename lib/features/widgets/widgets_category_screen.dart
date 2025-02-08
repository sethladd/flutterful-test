import 'package:flutter/material.dart';
import 'package:flutterful/features/widgets/models/widget_category.dart';
import 'package:flutterful/features/widgets/widget_detail_screen.dart';

class WidgetsCategoryScreen extends StatelessWidget {
  final WidgetCategory category;

  const WidgetsCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: category.widgets.length,
        itemBuilder: (context, index) {
          final widget = category.widgets[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _WidgetCard(
              title: widget.name,
              description: widget.description,
              types: widget.types,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WidgetDetailScreen(widget: widget),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WidgetCard extends StatelessWidget {
  final String title;
  final String description;
  final List<WidgetType> types;
  final VoidCallback onTap;

  const _WidgetCard({
    required this.title,
    required this.description,
    required this.types,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: types.map((type) => _TypeChip(type: type)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final WidgetType type;

  const _TypeChip({required this.type});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        type.name[0].toUpperCase() + type.name.substring(1),
        style: TextStyle(
          color: _getTypeColor(type),
        ),
      ),
      backgroundColor: _getTypeColor(type).withOpacity(0.1),
    );
  }

  Color _getTypeColor(WidgetType type) {
    switch (type) {
      case WidgetType.foundational:
        return Colors.blue;
      case WidgetType.material:
        return Colors.green;
      case WidgetType.cupertino:
        return Colors.purple;
    }
  }
}
