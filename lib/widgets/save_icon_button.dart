import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// This widget represents reusable save button
class SaveIconButton extends StatelessWidget {
  /// Creates a new instance
  const SaveIconButton({required this.callback});

  /// Callback function
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: callback,
      icon: const Icon(Icons.save),
      tooltip: 'Save',
    );
  }
}
