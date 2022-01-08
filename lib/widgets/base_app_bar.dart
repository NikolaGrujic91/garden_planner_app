// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/screens/calendar_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/icon_constants.dart';
import 'package:garden_planner_app/widgets/save_button.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';

/// This widget implements base app bar
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a new instance
  const BaseAppBar({
    Key? key,
    this.backScreenID,
    this.showCalendarButton,
    required this.title,
    this.saveCallback,
  }) : super(key: key);

  /// Back button screen ID
  final String? backScreenID;

  /// Show calendar button
  final bool? showCalendarButton;

  /// Title in the app bar
  final String title;

  /// Save button callback
  final AsyncCallback? saveCallback;

  @override
  Widget build(BuildContext context) {
    final actions = <Widget>[];

    if (saveCallback != null) {
      actions.add(
        SaveButton(
          callback: () async {
            await saveCallback!();
          },
        ),
      );
    }

    Widget? calendarButton;

    if (showCalendarButton != null && showCalendarButton!) {
      calendarButton = IconButton(
        onPressed: () {
          Navigator.pushReplacementNamed(
            context,
            CalendarScreen.id,
          );
        },
        icon: Icon(kCalendarIcon),
      );

      actions.add(calendarButton);
    }

    Widget? backButton;

    if (backScreenID != null) {
      backButton = IconButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, backScreenID!);
        },
        icon: Icon(kBackIcon),
      );
    }

    return AppBar(
      backgroundColor: kAppBarBackgroundColor,
      leading: backButton,
      title: StyledText(text: title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
