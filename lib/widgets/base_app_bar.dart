import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    this.forwardScreenID,
    required this.title,
    this.saveCallback,
  }) : super(key: key);

  /// Back button screen ID
  final String? backScreenID;

  /// Forward button screen ID
  final String? forwardScreenID;

  /// Title in the app bar
  final String title;

  /// Save button callback
  final AsyncCallback? saveCallback;

  @override
  Widget build(BuildContext context) {
    final actions = <Widget>[];

    if (saveCallback != null) {
      actions.add(SaveButton(
        callback: () async {
          await saveCallback!();
        },
      ));
    }

    Widget? forwardButton;

    if (forwardScreenID != null) {
      forwardButton = IconButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, forwardScreenID!);
        },
        icon: Icon(kForwardIcon),
      );

      actions.add(forwardButton);
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
