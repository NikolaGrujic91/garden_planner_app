import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldBordered extends StatelessWidget {
  TextFieldBordered({required String text, required this.hintText, required this.callback, this.index}) {
    _textEditingController = TextEditingController(text: text);
    _textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: _textEditingController.text.length));

    _decoration = InputDecoration(
      border: OutlineInputBorder(),
      hintText: hintText,
    );
  }

  final String hintText;
  final Function callback;
  final int? index;

  late final TextEditingController _textEditingController;
  late final InputDecoration _decoration;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: _decoration,
      controller: _textEditingController,
      onChanged: (value) {
        if (index == null) {
          callback(value);
        } else {
          callback(value, index);
        }
      },
    );
  }
}
