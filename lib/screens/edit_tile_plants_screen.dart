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
import '../utils/constants.dart';

class EditTilePlantsScreen extends StatefulWidget {
  static const String id = 'edit_tile_plants_screen';

  @override
  _EditTilePlantsScreenState createState() => _EditTilePlantsScreenState();
}

class _EditTilePlantsScreenState extends State<EditTilePlantsScreen> {
  TileType _tileType = TileType.plant;
  String _plantName = '';
  String _plantedDate = '';

  @override
  void initState() {
    super.initState();

    var gardensStore = Provider.of<GardensStore>(context, listen: false);
    Garden selectedGarden = gardensStore.gardens[gardensStore.selectedGardenIndex];
    Tile selectedTile = selectedGarden.tiles[gardensStore.selectedTileIndex];
    _tileType = selectedTile.type;
    _plantName = selectedTile.plantName;
    _plantedDate = selectedTile.plantedDate;
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
            title: Text('Edit tile plants'),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Visibility(
                    visible: _tileType == TileType.plant,
                    child: TextFieldBordered(
                      text: _plantName,
                      hintText: 'Plant name',
                      callback: _setPlantName,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: _tileType == TileType.plant,
                    child: Row(
                      children: [
                        Text(_plantedDate),
                        SizedBox(
                          width: _plantedDate.isEmpty ? 0.0 : 20.0,
                        ),
                        DatePicker(
                          restorationId: EditTilePlantsScreen.id,
                          callback: _setPlantedDate,
                          initialDate: _plantedDate,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _setPlantName(String plantName) {
    setState(() {
      _plantName = plantName;
    });
  }

  void _setPlantedDate(String plantedDate) {
    setState(() {
      _plantedDate = plantedDate;
    });
  }

  Future<void> _save() async {
    var gardensStore = Provider.of<GardensStore>(context, listen: false);
    gardensStore.updateSelectedTile(type: _tileType, plantName: _plantName, plantedDate: _plantedDate);
    await gardensStore.saveGardens();
    Navigator.pushReplacementNamed(context, TilesScreen.id);
  }
}
