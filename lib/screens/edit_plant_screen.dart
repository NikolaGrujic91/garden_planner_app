import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/plant.dart';
import 'package:garden_planner_app/screens/edit_event_screen.dart';
import 'package:garden_planner_app/screens/edit_plant_images_screen.dart';
import 'package:garden_planner_app/screens/plants_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/string_constants.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:garden_planner_app/widgets/alert_dialogs.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/date_picker.dart';
import 'package:garden_planner_app/widgets/plant_type_dropdown.dart';
import 'package:garden_planner_app/widgets/plant_type_picker.dart';
import 'package:garden_planner_app/widgets/styled_outlined_button.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:garden_planner_app/widgets/text_field_bordered.dart';
import 'package:provider/provider.dart';

/// Edit Plant Screen Widget
class EditPlantScreen extends StatefulWidget {
  /// Creates a new instance
  const EditPlantScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'edit_plant_screen';

  @override
  _EditPlantScreenState createState() => _EditPlantScreenState();
}

class _EditPlantScreenState extends State<EditPlantScreen> {
  late Plant _selectedPlant;
  late String _plantName;
  late String _plantedDate;
  late String _description;
  late PlantType _plantType;
  late String _plantTypeString;
  final _dropdownValues = <String>[kFlower, kFruit, kTree, kVegetable];
  final _isMobile = Platform.isAndroid || Platform.isIOS;

  @override
  void initState() {
    super.initState();

    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    _selectedPlant = gardensStore.getSelectedPlant();

    _plantName = _selectedPlant.name;
    _plantedDate = _selectedPlant.plantedDate;
    _description = _selectedPlant.description;
    _plantType = _selectedPlant.type;
    _plantTypeString = plantTypeToString(_selectedPlant.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backScreenID: PlantsScreen.id,
        title: 'Edit plant info',
        saveCallback: _save,
      ),
      body: Container(
        color: kBackgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Row(
              children: [
                if (Platform.isMacOS || Platform.isWindows)
                  PlantTypeDropdown(
                    dropdownValues: _dropdownValues,
                    value: _plantTypeString,
                    callback: _setPlantType,
                  )
                else
                  PlantTypePicker(
                    dropdownValues: _dropdownValues,
                    value: _plantTypeString,
                    callback: _setPlantType,
                  ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldBordered(
                    text: _plantName,
                    hintText: 'Plant name',
                    callback: _setPlantName,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldBordered(
                    text: _description,
                    hintText: 'Description',
                    callback: _setDescription,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const StyledText(
                  text: 'Planted:',
                ),
                const SizedBox(
                  width: 10,
                ),
                StyledText(
                  text: _plantedDate,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                DatePicker(
                  restorationId: EditPlantScreen.id,
                  callback: (String newValue) {
                    _setPlantedDate(newValue);
                  },
                  initialDate: _plantedDate,
                  text: 'Edit Planted Date',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const StyledText(
                  text: 'Watering:',
                ),
                const SizedBox(
                  width: 10,
                ),
                StyledText(
                  text: _plantedDate,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                StyledOutlinedButton(
                  text: 'Edit Watering Reminder',
                  onPressed: () async {
                    await Navigator.pushReplacementNamed(
                        context, EditEventScreen.id);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const StyledText(
                  text: 'Fertilize:',
                ),
                const SizedBox(
                  width: 10,
                ),
                StyledText(
                  text: _plantedDate,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                StyledOutlinedButton(
                  text: 'Edit Fertilize Reminder',
                  onPressed: () async {
                    await Navigator.pushReplacementNamed(
                        context, EditEventScreen.id);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (_isMobile)
              Row(
                children: [
                  StyledOutlinedButton(
                    text: 'Edit Images',
                    onPressed: () async {
                      await Navigator.pushReplacementNamed(
                          context, EditPlantImagesScreen.id);
                    },
                  ),
                ],
              ),
            if (_isMobile)
              const SizedBox(
                height: 20,
              ),
            Row(
              children: [
                StyledOutlinedButton(
                  text: 'Delete Plant',
                  onPressed: _showDeleteDialog,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _setPlantType(String plantType) {
    setState(() {
      _plantTypeString = plantType;
      _plantType = stringToPlantType(_plantTypeString);
    });
  }

  void _setPlantName(String plantName) {
    setState(() {
      _plantName = plantName;
    });
  }

  void _setDescription(String description) {
    setState(() {
      _description = description;
    });
  }

  void _setPlantedDate(String plantedDate) {
    setState(() {
      _plantedDate = plantedDate;
    });
  }

  Future<void> _save() async {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false)
      ..updateSelectedPlant(
          plantName: _plantName,
          plantedDate: _plantedDate,
          plantType: _plantType,
          description: _description);
    await gardensStore.saveGardens();

    if (!mounted) return;
    await Navigator.pushReplacementNamed(context, PlantsScreen.id);
  }

  Future<void> _showDeleteDialog() async {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    final name = gardensStore.getSelectedPlant().name;
    final content = 'Delete the plant "$name"?';

    return showDeleteDialog(context, content, _onDeletePressed);
  }

  Future<void> _onDeletePressed() async {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false)
      ..removeSelectedPlant();
    await gardensStore.saveGardens();

    if (!mounted) return;
    await Navigator.pushReplacementNamed(context, PlantsScreen.id);
  }
}
