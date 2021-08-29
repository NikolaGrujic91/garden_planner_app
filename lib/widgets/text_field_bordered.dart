import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garden_planner_app/utils/constants.dart';

/// This widget is generic widget for text input
class TextFieldBordered extends StatelessWidget {
  /// Creates a new instance
  TextFieldBordered(
      {required String text,
      required this.hintText,
      required this.callback,
      this.index}) {
    _textEditingController = TextEditingController(text: text);
    _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingController.text.length));

    _decoration = InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
      suffixIcon: IconButton(
        onPressed: () {
          _textEditingController.clear();
          if (index == null) {
            callback(_textEditingController.value.text);
          } else {
            callback(_textEditingController.value.text, index!);
          }
        },
        icon: const Icon(Icons.clear),
      ),
    );
  }

  /// Callback function on value changed
  final Function callback;

  /// Placeholder/hint text
  final String hintText;

  /// Optional index information for callback function
  final int? index;

  late final TextEditingController _textEditingController;
  late final InputDecoration _decoration;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: _decoration,
      controller: _textEditingController,
      style: kTextStyle,
      onChanged: (value) {
        if (index == null) {
          callback(value);
        } else {
          callback(value, index!);
        }
      },
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
    );
  }
}
