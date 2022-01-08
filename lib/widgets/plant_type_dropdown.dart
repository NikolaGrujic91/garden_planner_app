// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/icon_constants.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';

/// This widget enables picking plant type via modal dropdown
class PlantTypeDropdown extends StatelessWidget {
  /// Creates a new instance
  const PlantTypeDropdown({
    Key? key,
    required this.dropdownValues,
    required this.value,
    required this.callback,
  }) : super(key: key);

  /// List of values to display in the dropdown
  final List<String> dropdownValues;

  /// Value of initially selected value
  final String value;

  /// Callback function
  final Function(String plantType) callback;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      icon: Padding(
        padding: const EdgeInsets.only(
          bottom: 8,
        ),
        child: Icon(kDropdownArrow),
      ),
      elevation: 16,
      dropdownColor: kDropdownColor,
      style: const TextStyle(
        color: kDropdownTextColor,
      ),
      underline: Container(
        height: 2,
        color: kDropdownUnderlineColor,
      ),
      onChanged: (String? newValue) {
        callback(newValue!);
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
                child: plantTypeToSvgPicture(stringToPlantType(value)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 7,
                ),
                child: StyledText(text: value),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
