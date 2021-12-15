import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/string_constants.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:garden_planner_app/widgets/text_field_bordered_numeric.dart';

/// Show delete dialog.
/// Based on platform display Cupertino or Material alert dialog.
Future<void> showDeleteDialog(
  BuildContext context,
  String content,
  AsyncCallback onDeletePressed,
) async {
  return Platform.isIOS || Platform.isMacOS
      ? _showCupertinoDeleteDialog(context, content, onDeletePressed)
      : _showMaterialDeleteDialog(context, content, onDeletePressed);
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
              child: const StyledText(text: kDelete),
            )
          else
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const StyledText(text: kCancel),
            ),
          if (Platform.isWindows)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const StyledText(text: kCancel),
            )
          else
            TextButton(
              onPressed: () async {
                await onDeletePressed();
              },
              child: const StyledText(text: kDelete),
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
          child: const Text(kCancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text(kDelete),
          onPressed: () async {
            await onDeletePressed();
          },
        ),
      ],
    ),
  );
}

/// Show edit frequency dialog.
Future<void> showEditFrequencyDialog(
  BuildContext context,
  String content,
  Function(int newValue) callback,
  int currentValue,
) async {
  var value = currentValue;

  return showDialog<void>(
    context: context,

    /// user must tap button!
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: StyledText(
          text: content,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text('Repeat every'),
              const SizedBox(
                height: 20,
              ),
              TextFieldBorderedNumeric(
                text: value.toString(),
                hintText: '',
                callback: (int newValue) {
                  value = newValue;
                },
                maxValue: 10000,
                expanded: false,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('day(s)'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const StyledText(text: kCancel),
          ),
          TextButton(
            onPressed: () async {
              callback(value);
              Navigator.of(context).pop();
            },
            child: const StyledText(text: kSave),
          ),
        ],
      );
    },
  );
}
