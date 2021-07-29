import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SaveIconButton extends StatelessWidget {
  SaveIconButton({required this.callback});

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: this.callback,
      icon: const Icon(Icons.save),
      tooltip: 'Save',
    );
  }
}
