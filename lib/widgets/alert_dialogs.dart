import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';

/// Show delete dialog.
/// Based on platform display Cupertino or Material alert dialog.
Future<void> showDeleteDialog(
  BuildContext context,
  String content,
  AsyncCallback onDeletePressed,
) async {
  if (Platform.isIOS || Platform.isMacOS) {
    return _showCupertinoDeleteDialog(context, content, onDeletePressed);
  } else {
    return _showMaterialDeleteDialog(context, content, onDeletePressed);
  }
}

Future<void> _showMaterialDeleteDialog(
  BuildContext context,
  String content,
  AsyncCallback onDeletePressed,
) async {
  return showDialog<void>(
    context: context,

    /// user must tap button!
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const StyledText(
          text: 'Confirm delete',
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              StyledText(
                text: content,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          if (Platform.isWindows)
            TextButton(
              onPressed: () async {
                await onDeletePressed();
              },
              child: const StyledText(text: 'Delete'),
            )
          else
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const StyledText(text: 'Cancel'),
            ),
          if (Platform.isWindows)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const StyledText(text: 'Cancel'),
            )
          else
            TextButton(
              onPressed: () async {
                await onDeletePressed();
              },
              child: const StyledText(text: 'Delete'),
            ),
        ],
      );
    },
  );
}

Future<void> _showCupertinoDeleteDialog(
  BuildContext context,
  String content,
  AsyncCallback onDeletePressed,
) async {
  return showCupertinoDialog<void>(
    context: context,

    /// user must tap button!
    barrierDismissible: false,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Confirm delete'),
      content: Text(content),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text('Delete'),
          onPressed: () async {
            await onDeletePressed();
          },
        )
      ],
    ),
  );
}