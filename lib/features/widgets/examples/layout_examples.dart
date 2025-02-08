import 'package:flutter/material.dart';
import 'package:flutterful/features/graphics/widgets/source_code_view.dart';

class ContainerExample extends StatefulWidget {
  const ContainerExample({super.key});

  @override
  State<ContainerExample> createState() => _ContainerExampleState();
}

class _ContainerExampleState extends State<ContainerExample> {
  double padding = 16.0;
  AlignmentGeometry alignment = Alignment.center;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.blue.withOpacity(0.1),
            padding: const EdgeInsets.all(32),
            child: Container(
              padding: EdgeInsets.all(padding),
              alignment: alignment,
              color: Colors.white,
              child: const FlutterLogo(size: 100),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'A convenience widget that combines common painting, positioning, and sizing widgets.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Padding',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Value: ${padding.toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Slider(
                  value: padding,
                  min: 0,
                  max: 32,
                  onChanged: (value) => setState(() => padding = value),
                ),
                const SizedBox(height: 16),
                Text(
                  'Alignment',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SegmentedButton<AlignmentGeometry>(
                  segments: const [
                    ButtonSegment(
                      value: Alignment.topLeft,
                      label: Text('Top Left'),
                    ),
                    ButtonSegment(
                      value: Alignment.center,
                      label: Text('Center'),
                    ),
                    ButtonSegment(
                      value: Alignment.bottomRight,
                      label: Text('Bottom Right'),
                    ),
                  ],
                  selected: {alignment},
                  onSelectionChanged: (selected) {
                    setState(() => alignment = selected.first);
                  },
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
    return '''Container(
  padding: EdgeInsets.all(${padding.toStringAsFixed(1)}),
  alignment: $alignment,
  color: Colors.white,
  child: const FlutterLogo(size: 100),
)''';
  }
}

class RowExample extends StatefulWidget {
  const RowExample({super.key});

  @override
  State<RowExample> createState() => _RowExampleState();
}

class _RowExampleState extends State<RowExample> {
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.blue.withOpacity(0.1),
            padding: const EdgeInsets.all(32),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.red.withOpacity(0.5),
                ),
                Container(
                  width: 70,
                  height: 70,
                  color: Colors.green.withOpacity(0.5),
                ),
                Container(
                  width: 60,
                  height: 60,
                  color: Colors.blue.withOpacity(0.5),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Layout a list of child widgets in the horizontal direction.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Main Axis Alignment',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<MainAxisAlignment>(
                  value: mainAxisAlignment,
                  items: [
                    DropdownMenuItem(
                      value: MainAxisAlignment.start,
                      child: Text('Start'),
                    ),
                    DropdownMenuItem(
                      value: MainAxisAlignment.center,
                      child: Text('Center'),
                    ),
                    DropdownMenuItem(
                      value: MainAxisAlignment.end,
                      child: Text('End'),
                    ),
                    DropdownMenuItem(
                      value: MainAxisAlignment.spaceBetween,
                      child: Text('Space Between'),
                    ),
                    DropdownMenuItem(
                      value: MainAxisAlignment.spaceAround,
                      child: Text('Space Around'),
                    ),
                    DropdownMenuItem(
                      value: MainAxisAlignment.spaceEvenly,
                      child: Text('Space Evenly'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => mainAxisAlignment = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Cross Axis Alignment',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SegmentedButton<CrossAxisAlignment>(
                  segments: const [
                    ButtonSegment(
                      value: CrossAxisAlignment.start,
                      label: Text('Start'),
                    ),
                    ButtonSegment(
                      value: CrossAxisAlignment.center,
                      label: Text('Center'),
                    ),
                    ButtonSegment(
                      value: CrossAxisAlignment.end,
                      label: Text('End'),
                    ),
                  ],
                  selected: {crossAxisAlignment},
                  onSelectionChanged: (selected) {
                    setState(() => crossAxisAlignment = selected.first);
                  },
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
    return '''Row(
  mainAxisAlignment: MainAxisAlignment.${mainAxisAlignment.name},
  crossAxisAlignment: CrossAxisAlignment.${crossAxisAlignment.name},
  children: [
    Container(
      width: 50,
      height: 50,
      color: Colors.red.withOpacity(0.5),
    ),
    Container(
      width: 70,
      height: 70,
      color: Colors.green.withOpacity(0.5),
    ),
    Container(
      width: 60,
      height: 60,
      color: Colors.blue.withOpacity(0.5),
    ),
  ],
)''';
  }
}

class ColumnExample extends StatefulWidget {
  const ColumnExample({super.key});

  @override
  State<ColumnExample> createState() => _ColumnExampleState();
}

class _ColumnExampleState extends State<ColumnExample> {
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.blue.withOpacity(0.1),
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.red.withOpacity(0.5),
                ),
                Container(
                  width: 70,
                  height: 70,
                  color: Colors.green.withOpacity(0.5),
                ),
                Container(
                  width: 60,
                  height: 60,
                  color: Colors.blue.withOpacity(0.5),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Layout a list of child widgets in the vertical direction.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Main Axis Alignment',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<MainAxisAlignment>(
                  value: mainAxisAlignment,
                  items: [
                    DropdownMenuItem(
                      value: MainAxisAlignment.start,
                      child: Text('Start'),
                    ),
                    DropdownMenuItem(
                      value: MainAxisAlignment.center,
                      child: Text('Center'),
                    ),
                    DropdownMenuItem(
                      value: MainAxisAlignment.end,
                      child: Text('End'),
                    ),
                    DropdownMenuItem(
                      value: MainAxisAlignment.spaceBetween,
                      child: Text('Space Between'),
                    ),
                    DropdownMenuItem(
                      value: MainAxisAlignment.spaceAround,
                      child: Text('Space Around'),
                    ),
                    DropdownMenuItem(
                      value: MainAxisAlignment.spaceEvenly,
                      child: Text('Space Evenly'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => mainAxisAlignment = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Cross Axis Alignment',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SegmentedButton<CrossAxisAlignment>(
                  segments: const [
                    ButtonSegment(
                      value: CrossAxisAlignment.start,
                      label: Text('Start'),
                    ),
                    ButtonSegment(
                      value: CrossAxisAlignment.center,
                      label: Text('Center'),
                    ),
                    ButtonSegment(
                      value: CrossAxisAlignment.end,
                      label: Text('End'),
                    ),
                  ],
                  selected: {crossAxisAlignment},
                  onSelectionChanged: (selected) {
                    setState(() => crossAxisAlignment = selected.first);
                  },
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
    return '''Column(
  mainAxisAlignment: MainAxisAlignment.${mainAxisAlignment.name},
  crossAxisAlignment: CrossAxisAlignment.${crossAxisAlignment.name},
  children: [
    Container(
      width: 50,
      height: 50,
      color: Colors.red.withOpacity(0.5),
    ),
    Container(
      width: 70,
      height: 70,
      color: Colors.green.withOpacity(0.5),
    ),
    Container(
      width: 60,
      height: 60,
      color: Colors.blue.withOpacity(0.5),
    ),
  ],
)''';
  }
}

// More examples will be added...
