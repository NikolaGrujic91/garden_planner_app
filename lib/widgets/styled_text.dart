import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/constants.dart';

/// This widget represents styled text widget
class StyledText extends StatelessWidget {
  /// Creates a new instance
  const StyledText({Key? key, required this.text}) : super(key: key);

  /// Text
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kTextStyle,
    );
  }
}
