import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/style_constants.dart';

/// This widget represents reusable styled text widget
class StyledText extends StatelessWidget {
  /// Creates a styled text widget.
  const StyledText({Key? key, required this.text}) : super(key: key);

  /// The text to display.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kTextStyle,
    );
  }
}
