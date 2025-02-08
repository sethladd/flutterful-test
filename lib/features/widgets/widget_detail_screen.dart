import 'package:flutter/material.dart';
import 'package:flutterful/features/widgets/models/widget_category.dart';

class WidgetDetailScreen extends StatelessWidget {
  final WidgetItem widget;

  const WidgetDetailScreen({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.example,
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: widget.types
                      .map((type) => Chip(
                            label: Text(
                              type.name[0].toUpperCase() +
                                  type.name.substring(1),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
