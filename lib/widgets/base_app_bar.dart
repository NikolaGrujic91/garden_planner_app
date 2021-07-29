import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/save_icon_button.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? backScreenID;
  final String title;
  final AsyncCallback? saveCallback;

  const BaseAppBar({this.backScreenID, required this.title, this.saveCallback});

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = <Widget>[];

    if (this.saveCallback != null) {
      actions.add(SaveIconButton(callback: () async {
        await saveCallback!();
      }));
    }

    Widget? backButton;

    if (this.backScreenID != null) {
      backButton = IconButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, this.backScreenID!);
        },
        icon: Icon(kBackIcon),
      );
    }

    return AppBar(
      backgroundColor: kAppBarBackgroundColor,
      leading: backButton,
      title: Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
