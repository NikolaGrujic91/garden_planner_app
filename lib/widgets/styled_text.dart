// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/style_constants.dart';

/// This widget represents reusable styled text widget
class StyledText extends StatelessWidget {
  /// Creates a styled text widget.
  const StyledText({super.key, required this.text});

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
