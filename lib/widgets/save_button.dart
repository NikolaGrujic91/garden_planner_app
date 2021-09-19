import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// This widget represents reusable save button
class SaveButton extends StatelessWidget {
  /// Creates a new instance
  const SaveButton({
    Key? key,
    required this.callback,
  }) : super(key: key);

  /// Callback function
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callback,
      child: const Text(
        'SAVE',
        style: TextStyle(
          fontFamily: 'Roboto Sans',
          color: Colors.white,
        ),
      ),
    );
  }
}
