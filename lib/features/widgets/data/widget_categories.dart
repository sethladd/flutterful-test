import 'package:flutter/material.dart';
import 'package:flutterful/features/widgets/models/widget_category.dart';
import 'package:flutterful/features/widgets/examples/layout_examples.dart';

final widgetCategories = [
  WidgetCategory(
    name: 'Layout',
    description: 'Core building blocks for structuring UI',
    icon: Icons.grid_view,
    widgets: [
      WidgetItem(
        name: 'Container',
        description:
            'A convenience widget that combines common painting, positioning, and sizing widgets.',
        types: [WidgetType.foundational],
        example: const ContainerExample(),
      ),
      WidgetItem(
        name: 'Row',
        description:
            'Layout a list of child widgets in the horizontal direction.',
        types: [WidgetType.foundational],
        example: const RowExample(),
      ),
      WidgetItem(
        name: 'Column',
        description:
            'Layout a list of child widgets in the vertical direction.',
        types: [WidgetType.foundational],
        example: const ColumnExample(),
      ),
      // More widgets will be added here...
    ],
  ),
  // More categories will be added...
];
