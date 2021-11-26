import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garden_planner_app/utils/style_constants.dart';

/// This widget is generic widget for numeric input
class TextFieldBorderedNumeric extends StatefulWidget {
  /// Creates a new instance
  TextFieldBorderedNumeric({
    Key? key,
    required this.text,
    required this.hintText,
    required this.callback,
    this.expanded = true,
    this.maxValue = 5,
  }) : super(key: key) {
    _textEditingController = TextEditingController(text: text);
    _textEditingController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _textEditingController.text.length,
      ),
    );
  }

  /// Callback function on value changed
  final Function(int value) callback;

  /// Placeholder/hint text
  final String hintText;

  /// Text
  final String text;

  /// Text field expanded
  final bool expanded;

  /// Max value that can be entered in the text field
  final int maxValue;

  late final TextEditingController _textEditingController;

  @override
  State<TextFieldBorderedNumeric> createState() =>
      _TextFieldBorderedNumericState();
}

class _TextFieldBorderedNumericState extends State<TextFieldBorderedNumeric> {
  @override
  Widget build(BuildContext context) {
    final isEmpty = widget._textEditingController.value.text.isEmpty;

    final decoration = InputDecoration(
      border: const OutlineInputBorder(),
      labelText: isEmpty ? '' : widget.hintText,
      hintText: isEmpty ? widget.hintText : '',
    );

    final textField = TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: decoration,
      controller: widget._textEditingController,
      style: kTextStyle,
      onChanged: (value) {
        final intValue = int.tryParse(value);

        if (intValue != null) {
          widget.callback(
            intValue > widget.maxValue ? widget.maxValue : intValue,
          );
        }
      },
    );

    return widget.expanded
        ? Expanded(
            child: textField,
          )
        : textField;
  }
}
