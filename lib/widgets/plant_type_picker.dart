import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../utils/constants.dart';
import '../utils/utility.dart';

class PlantTypePicker extends StatelessWidget {
  final List<String> dropdownValues;
  final String value;
  final int index;
  final Function callback;

  const PlantTypePicker({Key? key, required this.dropdownValues, required this.value, required this.index, required this.callback}) : super(key: key);

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
    showMaterialRadioPicker<String>(
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
