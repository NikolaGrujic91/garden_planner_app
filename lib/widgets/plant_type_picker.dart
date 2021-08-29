import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:garden_planner_app/utils/constants.dart';
import 'package:garden_planner_app/utils/utility.dart';

/// This widget enables picking plant type via modal dialog
class PlantTypePicker extends StatelessWidget {
  /// Creates a new instance
  const PlantTypePicker({
    Key? key,
    required this.dropdownValues,
    required this.value,
    required this.index,
    required this.callback,
  }) : super(key: key);

  /// List of values to display in the picker
  final List<String> dropdownValues;

  /// Value of initially selected value
  final String value;

  /// Index of selected tile
  final int index;

  /// Callback function
  final Function(String plantType, int index) callback;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await _showPlantTypePicker(context, index);
      },
      icon: plantTypeToIconData(stringToPlantType(value)),
    );
  }

  Future<void> _showPlantTypePicker(BuildContext context, int index) async {
    await showMaterialRadioPicker<String>(
      context: context,
      headerColor: kAppBarBackgroundColor,
      title: 'Pick plant type',
      items: dropdownValues,
      selectedItem: value,
      onChanged: (newValue) {
        callback(newValue, index);
      },
    );
  }
}
