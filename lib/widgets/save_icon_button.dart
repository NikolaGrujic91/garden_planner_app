import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/icon_constants.dart';

/// This widget represents reusable save button
class SaveIconButton extends StatelessWidget {
  /// Creates a new instance
  const SaveIconButton({
    Key? key,
    required this.callback,
  }) : super(key: key);

  /// Callback function
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: callback,
      icon: const Icon(kSaveIcon),
      tooltip: 'Save',
    );
  }
}
