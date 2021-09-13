import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garden_planner_app/utils/style_constants.dart';

/// This widget is generic widget for numeric input
class TextFieldBorderedNumeric extends StatelessWidget {
  /// Creates a new instance
  TextFieldBorderedNumeric({
    Key? key,
    required this.text,
    required this.hintText,
    required this.callback,
  }) : super(key: key) {
    _textEditingController = TextEditingController(text: text);
    _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingController.text.length));

    _decoration = InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
      suffixIcon: IconButton(
        onPressed: _textEditingController.clear,
        icon: const Icon(Icons.clear),
      ),
    );
  }

  /// Callback function on value changed
  final Function(int value) callback;

  /// Placeholder/hint text
  final String hintText;

  /// Text
  final String text;

  late final TextEditingController _textEditingController;
  late final InputDecoration _decoration;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: _decoration,
        controller: _textEditingController,
        style: kTextStyle,
        onChanged: (value) {
          final intValue = int.tryParse(value);

          if (intValue != null) {
            callback(intValue);
          }
        },
      ),
    );
  }
}
