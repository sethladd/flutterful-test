import 'package:flutter/material.dart';

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
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(padding),
            alignment: alignment,
            color: Colors.blue.withOpacity(0.1),
            child: const FlutterLogo(size: 100),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Padding: ${padding.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Slider(
                value: padding,
                min: 0,
                max: 32,
                onChanged: (value) => setState(() => padding = value),
              ),
              const SizedBox(height: 16),
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
                onSelectionChanged: (selected) => setState(
                  () => alignment = selected.first,
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.blue.withOpacity(0.1),
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
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Main Axis Alignment',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SegmentedButton<MainAxisAlignment>(
                segments: const [
                  ButtonSegment(
                    value: MainAxisAlignment.start,
                    label: Text('Start'),
                  ),
                  ButtonSegment(
                    value: MainAxisAlignment.center,
                    label: Text('Center'),
                  ),
                  ButtonSegment(
                    value: MainAxisAlignment.end,
                    label: Text('End'),
                  ),
                ],
                selected: {mainAxisAlignment},
                onSelectionChanged: (selected) => setState(
                  () => mainAxisAlignment = selected.first,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Cross Axis Alignment',
                style: Theme.of(context).textTheme.titleSmall,
              ),
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
                onSelectionChanged: (selected) => setState(
                  () => crossAxisAlignment = selected.first,
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.blue.withOpacity(0.1),
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
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Main Axis Alignment',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SegmentedButton<MainAxisAlignment>(
                segments: const [
                  ButtonSegment(
                    value: MainAxisAlignment.start,
                    label: Text('Start'),
                  ),
                  ButtonSegment(
                    value: MainAxisAlignment.center,
                    label: Text('Center'),
                  ),
                  ButtonSegment(
                    value: MainAxisAlignment.end,
                    label: Text('End'),
                  ),
                ],
                selected: {mainAxisAlignment},
                onSelectionChanged: (selected) => setState(
                  () => mainAxisAlignment = selected.first,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Cross Axis Alignment',
                style: Theme.of(context).textTheme.titleSmall,
              ),
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
                onSelectionChanged: (selected) => setState(
                  () => crossAxisAlignment = selected.first,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// More examples will be added...
