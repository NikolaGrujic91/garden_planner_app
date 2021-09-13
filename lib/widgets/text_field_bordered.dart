import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garden_planner_app/utils/style_constants.dart';

/// This widget is generic widget for text input
class TextFieldBordered extends StatelessWidget {
  /// Creates a new instance
  TextFieldBordered({
    Key? key,
    required String text,
    required this.hintText,
    this.callback,
  }) : super(key: key) {
    _textEditingController = TextEditingController(text: text);
    _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingController.text.length));

    _decoration = InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
      suffixIcon: IconButton(
        onPressed: () {
          _textEditingController.clear();
          callback!(_textEditingController.value.text);
        },
        icon: const Icon(Icons.clear),
      ),
    );
  }

  /// Callback function on value changed
  final Function(String value)? callback;

  /// Placeholder/hint text
  final String hintText;

  late final TextEditingController _textEditingController;
  late final InputDecoration _decoration;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: _decoration,
      controller: _textEditingController,
      style: kTextStyle,
      onChanged: (value) {
        callback!(value);
      },
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
    );
  }
}
