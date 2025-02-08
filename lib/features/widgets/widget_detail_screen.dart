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
        ],
      ),
    );
  }
}
