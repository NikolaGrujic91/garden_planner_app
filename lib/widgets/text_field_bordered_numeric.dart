import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garden_planner_app/utils/constants.dart';

class TextFieldBorderedNumeric extends StatelessWidget {
  final Function callback;
  final String hintText;
  final String text;

  late final TextEditingController _textEditingController;
  late final InputDecoration _decoration;

  TextFieldBorderedNumeric({required this.text, required this.hintText, required this.callback}) {
    _textEditingController = TextEditingController(text: this.text);
    _textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: _textEditingController.text.length));

    _decoration = InputDecoration(
      border: OutlineInputBorder(),
      hintText: this.hintText,
      suffixIcon: IconButton(
        onPressed: () {
          _textEditingController.clear();
        },
        icon: Icon(Icons.clear),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: _decoration,
        controller: this._textEditingController,
        style: kTextStyle,
        onChanged: (value) {
          var intValue = int.tryParse(value);

          if (intValue != null) {
            callback(intValue);
          }
        },
      ),
    );
  }
}
