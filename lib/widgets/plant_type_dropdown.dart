import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/utility.dart';
import 'styled_text.dart';

class PlantTypeDropdown extends StatelessWidget {
  final List<String> dropdownValues;
  final String value;
  final int index;
  final Function callback;

  const PlantTypeDropdown({Key? key, required this.dropdownValues, required this.value, required this.index, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      icon: Padding(
        padding: const EdgeInsets.only(
          bottom: 8.0,
        ),
        child: const Icon(kDropdownArrow),
      ),
      iconSize: 24,
      elevation: 16,
      dropdownColor: kDropdownColor,
      style: const TextStyle(
        color: kDropdownText,
      ),
      underline: Container(
        height: 2,
        color: kDropdownUnderline,
      ),
      onChanged: (String? newValue) {
        callback(newValue!, index);
      },
      items: dropdownValues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Wrap(
            spacing: 12.0,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: plantTypeToIconData(stringToPlantType(value)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7.0),
                child: StyledText(text: value),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
