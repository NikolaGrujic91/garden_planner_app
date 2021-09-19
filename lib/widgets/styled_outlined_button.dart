import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/style_constants.dart';

/// This widget represents reusable styled outlined button widget
class StyledOutlinedButton extends StatelessWidget {
  /// Creates a styled OutlinedButton widget
  const StyledOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  /// The text to display.
  final String text;

  /// Called when the button is tapped or otherwise activated.
  final AsyncCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () async {
          await onPressed();
        },
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: kFontFamily,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
