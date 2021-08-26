import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garden_planner_app/utils/constants.dart';

class TextFieldBordered extends StatelessWidget {
  final String hintText;
  final Function callback;
  final int? index;

  late final TextEditingController _textEditingController;
  late final InputDecoration _decoration;

  TextFieldBordered({required String text, required this.hintText, required this.callback, this.index}) {
    _textEditingController = TextEditingController(text: text);
    _textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: _textEditingController.text.length));

    _decoration = InputDecoration(
      border: OutlineInputBorder(),
      hintText: hintText,
      suffixIcon: IconButton(
        onPressed: () {
          _textEditingController.clear();
          if (index == null) {
            callback(_textEditingController.value.text);
          } else {
            callback(_textEditingController.value.text, index);
          }
        },
        icon: Icon(Icons.clear),
      ),
    );
  }

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
          callback(value, index);
        }
      },
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
    );
  }
}
