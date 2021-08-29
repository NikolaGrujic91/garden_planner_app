import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/constants.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';

/// This widget enables picking plant type via modal dropdown
class PlantTypeDropdown extends StatelessWidget {
  /// Creates a new instance
  const PlantTypeDropdown({
    Key? key,
    required this.dropdownValues,
    required this.value,
    required this.index,
    required this.callback,
  }) : super(key: key);

  /// List of values to display in the dropdown
  final List<String> dropdownValues;

  /// Value of initially selected value
  final String value;

  /// Index of selected tile
  final int index;

  /// Callback function
  final Function(String plantType, int index) callback;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      icon: const Padding(
        padding: EdgeInsets.only(
          bottom: 8,
        ),
        child: Icon(kDropdownArrow),
      ),
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
            spacing: 12,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: plantTypeToIconData(stringToPlantType(value)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 7,
                ),
                child: StyledText(text: value),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
