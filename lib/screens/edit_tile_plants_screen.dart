import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tiles_screen.dart';
import '../widgets/save_icon_button.dart';
import '../widgets/text_field_bordered.dart';
import '../widgets/date_picker.dart';
import '../model/gardens_store.dart';
import '../model/enums.dart';
import '../model/garden.dart';
import '../model/tile.dart';
import '../model/plant.dart';
import '../utils/constants.dart';
import '../utils/utility.dart';

class EditTilePlantsScreen extends StatefulWidget {
  static const String id = 'edit_tile_plants_screen';

  @override
  _EditTilePlantsScreenState createState() => _EditTilePlantsScreenState();
}

class _EditTilePlantsScreenState extends State<EditTilePlantsScreen> {
  late Tile _selectedTile;
  List<String> _plantsNames = <String>[];
  List<String> _plantedDates = <String>[];
  List<PlantType> _plantsTypes = <PlantType>[];
  List<String> _plantsTypesString = <String>[];
  List<String> _dropdownValues = <String>[kFlower, kFruit, kTree, kVegetable];

  @override
  void initState() {
    super.initState();

    var gardensStore = Provider.of<GardensStore>(context, listen: false);
    Garden selectedGarden = gardensStore.gardens[gardensStore.selectedGardenIndex];
    _selectedTile = selectedGarden.tiles[gardensStore.selectedTileIndex];

    for (Plant plant in _selectedTile.plants) {
      _plantsNames.add(plant.name);
      _plantedDates.add(plant.plantedDate);
      _plantsTypes.add(plant.type);
      _plantsTypesString.add(plantTypeToString(plant.type));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GardensStore>(
      builder: (context, gardensStore, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kAppBarBackgroundColor,
            leading: new IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, TilesScreen.id);
              },
              icon: new Icon(Icons.arrow_back_ios),
            ),
            title: Text('Edit plants'),
            actions: [
              SaveIconButton(
                callback: () async {
                  await _save();
                },
              ),
            ],
          ),
          body: Container(
            color: kBackgroundColor,
            child: ListView.builder(
              itemCount: _selectedTile.plants.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      DropdownButton<String>(
                        value: _plantsTypesString[index],
                        icon: const Icon(kDropdownArrow),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(
                          color: kDropdownText,
                        ),
                        underline: Container(
                          height: 2,
                          color: kDropdownUnderline,
                        ),
                        onChanged: (String? newValue) {
                          _setPlantType(newValue!, index);
                        },
                        items: _dropdownValues.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: TextFieldBordered(
                          text: _plantsNames[index],
                          hintText: 'Plant name',
                          callback: _setPlantName,
                          index: index,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(_plantedDates[index]),
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
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
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

  void _setPlantedDate(String plantedDate, int index) {
    setState(() {
      _plantedDates[index] = plantedDate;
    });
  }

  Future<void> _save() async {
    var gardensStore = Provider.of<GardensStore>(context, listen: false);
    gardensStore.updateSelectedTilePlants(plantsNames: _plantsNames, plantedDates: _plantedDates, plantsTypes: _plantsTypes);
    await gardensStore.saveGardens();
    Navigator.pushReplacementNamed(context, TilesScreen.id);
  }
}
