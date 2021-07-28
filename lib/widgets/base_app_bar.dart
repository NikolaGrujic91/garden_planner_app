import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/save_icon_button.dart';
import '../utils/constants.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String backScreenID;
  final String title;
  final AsyncCallback? saveCallback;
  final AppBar appBar;

  const BaseAppBar({required this.backScreenID, required this.title, required this.saveCallback, required this.appBar});

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = <Widget>[];

    if (this.saveCallback != null) {
      actions.add(SaveIconButton(callback: () async {
        await saveCallback!();
      }));
    }

    return AppBar(
      backgroundColor: kAppBarBackgroundColor,
      leading: IconButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, backScreenID);
        },
        icon: Icon(kBackIcon),
      ),
      title: Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
