// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/style_constants.dart';

/// This widget is generic widget for text input
class TextFieldBordered extends StatefulWidget {
  /// Creates a new instance
  TextFieldBordered({
    Key? key,
    required String text,
    required this.hintText,
    this.callback,
  }) : super(key: key) {
    _textEditingController = TextEditingController(text: text);
    _textEditingController.selection = TextSelection.fromPosition(
      TextPosition(offset: _textEditingController.text.length),
    );
  }

  /// Callback function on value changed
  final Function(String value)? callback;

  /// Placeholder/hint text
  final String hintText;

  late final TextEditingController _textEditingController;

  @override
  State<TextFieldBordered> createState() => _TextFieldBorderedState();
}

class _TextFieldBorderedState extends State<TextFieldBordered> {
  @override
  Widget build(BuildContext context) {
    final isEmpty = widget._textEditingController.value.text.isEmpty;
    final _decoration = InputDecoration(
      border: const OutlineInputBorder(),
      labelText: isEmpty ? '' : widget.hintText,
      hintText: isEmpty ? widget.hintText : '',
    );

    return TextField(
      decoration: _decoration,
      controller: widget._textEditingController,
      style: kTextStyle,
      onChanged: (value) {
        widget.callback!(value);
      },
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
    );
  }
}
