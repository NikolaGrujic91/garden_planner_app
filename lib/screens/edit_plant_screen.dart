import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/plant.dart';
import 'package:garden_planner_app/screens/plants_screen.dart';
import 'package:garden_planner_app/screens/take_picture_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/icon_constants.dart';
import 'package:garden_planner_app/utils/string_constants.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/date_picker.dart';
import 'package:garden_planner_app/widgets/plant_type_dropdown.dart';
import 'package:garden_planner_app/widgets/plant_type_picker.dart';
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
    final isMobile = Platform.isAndroid || Platform.isIOS;

    final floatingActionButtonTakePicture = FloatingActionButton(
      onPressed: () async {
        await Navigator.pushReplacementNamed(context, TakePictureScreen.id);
      },
      tooltip: 'Take picture',
      backgroundColor: kFloatingActionButtonColor,
      child: const Icon(kCameraIcon),
    );

    return Scaffold(
      appBar: BaseAppBar(
        backScreenID: PlantsScreen.id,
        title: 'Edit plants',
        saveCallback: _save,
      ),
      floatingActionButton: isMobile ? floatingActionButtonTakePicture : null,
      body: Container(
        color: kBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
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
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      await _showDeleteDialog();
                    },
                    icon: const Icon(kDeleteIcon),
                    tooltip: 'Delete plant',
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                height: 10,
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
                height: 10,
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
                  const Spacer(),
                  DatePicker(
                    restorationId: EditPlantScreen.id,
                    callback: (String newValue) {
                      _setPlantedDate(newValue);
                    },
                    initialDate: _plantedDate,
                  ),
                ],
              ),
            ],
          ),
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

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const StyledText(
            text: 'Confirm delete',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                StyledText(
                  text: content,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            if (Platform.isWindows)
              TextButton(
                onPressed: () async {
                  await _onDeletePressed();
                },
                child: const StyledText(text: 'Delete'),
              )
            else
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const StyledText(text: 'Cancel'),
              ),
            if (Platform.isWindows)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const StyledText(text: 'Cancel'),
              )
            else
              TextButton(
                onPressed: () async {
                  await _onDeletePressed();
                },
                child: const StyledText(text: 'Delete'),
              ),
          ],
        );
      },
    );
  }

  Future<void> _onDeletePressed() async {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false)
      ..removeSelectedPlant();
    await gardensStore.saveGardens();

    if (!mounted) return;
    await Navigator.pushReplacementNamed(context, PlantsScreen.id);
  }
}
