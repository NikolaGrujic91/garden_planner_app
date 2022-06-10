// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/utility.dart';

/// This widget enables picking plant type via modal dialog
class PlantTypePicker extends StatelessWidget {
  /// Creates a new instance
  const PlantTypePicker({
    super.key,
    required this.dropdownValues,
    required this.value,
    required this.callback,
  });

  /// List of values to display in the picker
  final List<String> dropdownValues;

  /// Value of initially selected value
  final String value;

  /// Callback function
  final Function(String plantType) callback;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await _showPlantTypePicker(context);
      },
      icon: plantTypeToSvgPicture(stringToPlantType(value)),
    );
  }

  Future<void> _showPlantTypePicker(BuildContext context) async {
    await showMaterialRadioPicker<String>(
      context: context,
      headerColor: kAppBarBackgroundColor,
      title: 'Pick plant type',
      items: dropdownValues,
      selectedItem: value,
      onChanged: callback,
    );
  }
}
