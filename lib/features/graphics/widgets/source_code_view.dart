import 'package:flutter/material.dart';

class SourceCodeView extends StatefulWidget {
  final String sourceCode;

  const SourceCodeView({
    super.key,
    required this.sourceCode,
  });

  @override
  State<SourceCodeView> createState() => _SourceCodeViewState();
}

class _SourceCodeViewState extends State<SourceCodeView> {
  var _showCode = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          onPressed: () => setState(() => _showCode = !_showCode),
          icon: Icon(_showCode ? Icons.code_off : Icons.code),
          label: Text(_showCode ? 'Hide Code' : 'Show Code'),
        ),
        if (_showCode) ...[
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
            child: SelectableText(
              widget.sourceCode,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                  ),
            ),
          ),
        ],
      ],
    );
  }
}
