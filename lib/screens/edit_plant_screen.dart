import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/plant.dart';
import 'package:garden_planner_app/model/plant_parameter_object.dart';
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
  State<EditPlantScreen> createState() => _EditPlantScreenState();
}

class _EditPlantScreenState extends State<EditPlantScreen> {
  late Plant _selectedPlant;
  late String _plantName;
  late String _plantedDate;
  late String _wateringStartDate;
  late int _wateringFrequency;
  late String _fertilizingStartDate;
  late int _fertilizingFrequency;
  late String _pesticideStartDate;
  late int _pesticideFrequency;
  late String _description;
  late PlantType _plantType;
  late String _plantTypeString;
  final _dropdownValues = <String>[kFlower, kFruit, kTree, kVegetable];
  final _isMobile = Platform.isAndroid || Platform.isIOS;
  final _verticalSpace = const SizedBox(
    height: 20,
  );
  final _horizontalSpace = const SizedBox(
    width: 10,
  );

  @override
  void initState() {
    super.initState();

    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    _selectedPlant = gardensStore.getSelectedPlant();

    _plantName = _selectedPlant.name;
    _plantedDate = _selectedPlant.plantedDate;
    _wateringStartDate = _selectedPlant.wateringStartDate;
    _wateringFrequency = _selectedPlant.wateringFrequency;
    _fertilizingStartDate = _selectedPlant.fertilizingStartDate;
    _fertilizingFrequency = _selectedPlant.fertilizingFrequency;
    _pesticideStartDate = _selectedPlant.pesticideStartDate;
    _pesticideFrequency = _selectedPlant.pesticideFrequency;
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
      body: SafeArea(
        child: Container(
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
              _verticalSpace,
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
              _verticalSpace,
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
              _verticalSpace,
              Row(
                children: [
                  const StyledText(
                    text: 'Planted:',
                  ),
                  _horizontalSpace,
                  StyledText(
                    text: _plantedDate,
                  ),
                ],
              ),
              _verticalSpace,
              Row(
                children: [
                  DatePicker(
                    callback: (String newValue) {
                      _setPlantedDate(newValue);
                    },
                    initialDate: _plantedDate,
                    text: 'Edit Planted Date',
                  ),
                ],
              ),
              _verticalSpace,
              Row(
                children: [
                  const StyledText(
                    text: 'Watering start date:',
                  ),
                  _horizontalSpace,
                  StyledText(
                    text: _wateringStartDate,
                  ),
                ],
              ),
              _verticalSpace,
              Row(
                children: [
                  DatePicker(
                    callback: (String newValue) {
                      _setWateringStartDate(newValue);
                    },
                    initialDate: _wateringStartDate,
                    text: 'Edit Watering start date',
                  ),
                ],
              ),
              _verticalSpace,
              StyledText(
                text: 'Water every ${_wateringFrequency.toString()} day(s)',
              ),
              _verticalSpace,
              Row(
                children: [
                  StyledOutlinedButton(
                    text: 'Edit Watering frequency',
                    onPressed: _showEditWateringFrequencyDialog,
                  ),
                ],
              ),
              _verticalSpace,
              Row(
                children: [
                  const StyledText(
                    text: 'Fertilizing start date:',
                  ),
                  _horizontalSpace,
                  StyledText(
                    text: _fertilizingStartDate,
                  ),
                ],
              ),
              _verticalSpace,
              Row(
                children: [
                  DatePicker(
                    callback: (String newValue) {
                      _setFertilizingStartDate(newValue);
                    },
                    initialDate: _fertilizingStartDate,
                    text: 'Edit Fertilizing start date',
                  ),
                ],
              ),
              _verticalSpace,
              StyledText(
                text: 'Fertilize every ${_fertilizingFrequency.toString()} '
                    'day(s)',
              ),
              _verticalSpace,
              Row(
                children: [
                  StyledOutlinedButton(
                    text: 'Edit Fertilizing frequency',
                    onPressed: _showEditFertilizingFrequencyDialog,
                  ),
                ],
              ),
              _verticalSpace,
              Row(
                children: [
                  const StyledText(
                    text: 'Pesticide start date:',
                  ),
                  _horizontalSpace,
                  StyledText(
                    text: _pesticideStartDate,
                  ),
                ],
              ),
              _verticalSpace,
              Row(
                children: [
                  DatePicker(
                    callback: (String newValue) {
                      _setPesticideStartDate(newValue);
                    },
                    initialDate: _pesticideStartDate,
                    text: 'Edit Pesticide start date',
                  ),
                ],
              ),
              _verticalSpace,
              StyledText(
                text:
                    'Pesticide every ${_pesticideFrequency.toString()} day(s)',
              ),
              _verticalSpace,
              Row(
                children: [
                  StyledOutlinedButton(
                    text: 'Edit Pesticide frequency',
                    onPressed: _showEditPesticideFrequencyDialog,
                  ),
                ],
              ),
              _verticalSpace,
              if (_isMobile)
                Row(
                  children: [
                    StyledOutlinedButton(
                      text: 'Edit Images',
                      onPressed: () async {
                        await Navigator.pushReplacementNamed(
                          context,
                          EditPlantImagesScreen.id,
                        );
                      },
                    ),
                  ],
                ),
              if (_isMobile) _verticalSpace,
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

  void _setWateringStartDate(String wateringStartDate) {
    setState(() {
      _wateringStartDate = wateringStartDate;
    });
  }

  void _setWateringFrequency(int wateringFrequency) {
    setState(() {
      _wateringFrequency = wateringFrequency;
    });
  }

  void _setFertilizingStartDate(String fertilizingStartDate) {
    setState(() {
      _fertilizingStartDate = fertilizingStartDate;
    });
  }

  void _setFertilizingFrequency(int fertilizingFrequency) {
    setState(() {
      _fertilizingFrequency = fertilizingFrequency;
    });
  }

  void _setPesticideStartDate(String pesticideStartDate) {
    setState(() {
      _pesticideStartDate = pesticideStartDate;
    });
  }

  void _setPesticideFrequency(int pesticideFrequency) {
    setState(() {
      _pesticideFrequency = pesticideFrequency;
    });
  }

  Future<void> _save() async {
    final parameter = PlantParameterObject(
      type: _plantType,
      name: _plantName,
      plantedDate: _plantedDate,
      description: _description,
      wateringStartDate: _wateringStartDate,
      wateringFrequency: _wateringFrequency,
      fertilizingStartDate: _fertilizingStartDate,
      fertilizingFrequency: _fertilizingFrequency,
      pesticideStartDate: _pesticideStartDate,
      pesticideFrequency: _pesticideFrequency,
    );

    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false)
      ..updateSelectedPlant(parameter: parameter);
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

  Future<void> _showEditWateringFrequencyDialog() async {
    return showEditFrequencyDialog(
      context,
      'Edit Watering Frequency',
      _setWateringFrequency,
      _wateringFrequency,
    );
  }

  Future<void> _showEditFertilizingFrequencyDialog() async {
    return showEditFrequencyDialog(
      context,
      'Edit Fertilizing Frequency',
      _setFertilizingFrequency,
      _fertilizingFrequency,
    );
  }

  Future<void> _showEditPesticideFrequencyDialog() async {
    return showEditFrequencyDialog(
      context,
      'Edit Pesticide Frequency',
      _setPesticideFrequency,
      _pesticideFrequency,
    );
  }
}
