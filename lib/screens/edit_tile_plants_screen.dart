import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/gardens_store.dart';
import 'package:garden_planner_app/model/tile.dart';
import 'package:garden_planner_app/screens/tiles_screen.dart';
import 'package:garden_planner_app/utils/constants.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/date_picker.dart';
import 'package:garden_planner_app/widgets/plant_type_dropdown.dart';
import 'package:garden_planner_app/widgets/plant_type_picker.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:garden_planner_app/widgets/text_field_bordered.dart';
import 'package:provider/provider.dart';

/// Edit Tile Plants Screen Widget
class EditTilePlantsScreen extends StatefulWidget {
  /// Creates a new instance
  const EditTilePlantsScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'edit_tile_plants_screen';

  @override
  _EditTilePlantsScreenState createState() => _EditTilePlantsScreenState();
}

class _EditTilePlantsScreenState extends State<EditTilePlantsScreen> {
  late Tile _selectedTile;
  final _plantsNames = <String>[];
  final _plantedDates = <String>[];
  final _descriptions = <String>[];
  final _plantsTypes = <PlantType>[];
  final _plantsTypesString = <String>[];
  final _dropdownValues = <String>[kFlower, kFruit, kTree, kVegetable];

  @override
  void initState() {
    super.initState();

    final gardensStore = Provider.of<GardensStore>(context, listen: false);
    final selectedGarden =
        gardensStore.gardens[gardensStore.selectedGardenIndex];
    _selectedTile = selectedGarden.tiles[gardensStore.selectedTileIndex];

    for (final plant in _selectedTile.plants) {
      _plantsNames.add(plant.name);
      _plantedDates.add(plant.plantedDate);
      _descriptions.add(plant.description);
      _plantsTypes.add(plant.type);
      _plantsTypesString.add(plantTypeToString(plant.type));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backScreenID: TilesScreen.id,
        title: 'Edit plants',
        saveCallback: _save,
      ),
      body: Container(
        color: kBackgroundColor,
        child: ListView.builder(
          itemCount: _selectedTile.plants.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (Platform.isMacOS || Platform.isWindows)
                        PlantTypeDropdown(
                          dropdownValues: _dropdownValues,
                          value: _plantsTypesString[index],
                          index: index,
                          callback: _setPlantType,
                        )
                      else
                        PlantTypePicker(
                          dropdownValues: _dropdownValues,
                          value: _plantsTypesString[index],
                          index: index,
                          callback: _setPlantType,
                        ),
                      const SizedBox(
                        width: 20,
                      ),
                      StyledText(text: _plantedDates[index]),
                      SizedBox(
                        width: _plantedDates[index].isEmpty ? 0.0 : 20.0,
                      ),
                      DatePicker(
                        restorationId: EditTilePlantsScreen.id,
                        callback: (String newValue) {
                          _setPlantedDate(newValue, index);
                        },
                        initialDate: _plantedDates[index],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          await _showDeleteDialog(
                            context,
                            index,
                          );
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
                          text: _plantsNames[index],
                          hintText: 'Plant name',
                          callbackWithIndex: _setPlantName,
                          index: index,
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
                          text: _descriptions[index],
                          hintText: 'Description',
                          callbackWithIndex: _setDescription,
                          index: index,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _setPlantType(String plantType, int index) {
    setState(() {
      _plantsTypesString[index] = plantType;
      _plantsTypes[index] = stringToPlantType(_plantsTypesString[index]);
    });
  }

  void _setPlantName(String plantName, int index) {
    setState(() {
      _plantsNames[index] = plantName;
    });
  }

  void _setDescription(String description, int index) {
    setState(() {
      _descriptions[index] = description;
    });
  }

  void _setPlantedDate(String plantedDate, int index) {
    setState(() {
      _plantedDates[index] = plantedDate;
    });
  }

  Future<void> _save() async {
    final gardensStore = Provider.of<GardensStore>(context, listen: false)
      ..updateSelectedTilePlants(
          plantsNames: _plantsNames,
          plantedDates: _plantedDates,
          plantsTypes: _plantsTypes,
          descriptions: _descriptions);
    await gardensStore.saveGardens();

    if (!mounted) return;
    await Navigator.pushReplacementNamed(context, TilesScreen.id);
  }

  Future<void> _showDeleteDialog(
    BuildContext context,
    int index,
  ) async {
    final gardensStore = Provider.of<GardensStore>(context, listen: false);
    final name = gardensStore.gardens[gardensStore.selectedGardenIndex]
        .tiles[gardensStore.selectedTileIndex].plants[index].name;
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
                  await _onDeletePressed(index);
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
                  await _onDeletePressed(index);
                },
                child: const StyledText(text: 'Delete'),
              ),
          ],
        );
      },
    );
  }

  Future<void> _onDeletePressed(int index) async {
    final gardensStore = Provider.of<GardensStore>(context, listen: false)
      ..removePlant(index: index);
    await gardensStore.saveGardens();

    if (!mounted) return;
    Navigator.of(context).pop();

    setState(() {
      _plantsNames.removeAt(index);
      _plantedDates.removeAt(index);
      _plantsTypes.removeAt(index);
      _plantsTypesString.removeAt(index);
    });
  }
}
