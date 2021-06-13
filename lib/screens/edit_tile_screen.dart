import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tiles_screen.dart';
import '../widgets/save_icon_button.dart';
import '../widgets/text_field_bordered.dart';
import '../widgets/date_picker.dart';
import '../model/plans_store.dart';
import '../model/enums.dart';
import '../model/plan.dart';
import '../model/tile.dart';

class EditTileScreen extends StatefulWidget {
  static const String id = 'edit_tile_screen';

  @override
  _EditTileScreenState createState() => _EditTileScreenState();
}

class _EditTileScreenState extends State<EditTileScreen> {
  TileType _tileType = TileType.plant;
  String _plantName = '';
  String _plantedDate = '';

  @override
  void initState() {
    super.initState();

    var plansStore = Provider.of<PlansStore>(context, listen: false);
    Plan selectedPlan = plansStore.plans[plansStore.selectedPlanIndex];
    Tile selectedTile = selectedPlan.tiles[plansStore.selectedTileIndex];
    _tileType = selectedTile.type;
    _plantName = selectedTile.plantName;
    _plantedDate = selectedTile.plantedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlansStore>(
      builder: (context, plansStore, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit tile'),
            actions: [
              SaveIconButton(
                callback: () async {
                  await _updateTile();
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                RadioListTile<TileType>(
                  title: const Text('Plant'),
                  value: TileType.plant,
                  groupValue: _tileType,
                  onChanged: _setTileType,
                ),
                RadioListTile<TileType>(
                  title: const Text('Home'),
                  value: TileType.home,
                  groupValue: _tileType,
                  onChanged: _setTileType,
                ),
                RadioListTile<TileType>(
                  title: const Text('Path'),
                  value: TileType.path,
                  groupValue: _tileType,
                  onChanged: _setTileType,
                ),
                RadioListTile<TileType>(
                  title: const Text('None'),
                  value: TileType.none,
                  groupValue: _tileType,
                  onChanged: _setTileType,
                ),
                const SizedBox(
                  height: 20.0,
                ),
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
                        restorationId: EditTileScreen.id,
                        callback: _setPlantedDate,
                        initialDate: _plantedDate,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _setTileType(TileType? type) {
    setState(() {
      _tileType = type!;
    });
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

  Future<void> _updateTile() async {
    var plansStore = Provider.of<PlansStore>(context, listen: false);
    plansStore.updateTile(type: _tileType, plantName: _plantName, plantedDate: _plantedDate);
    await plansStore.savePlans();
    Navigator.pushNamed(context, TilesScreen.id);
  }
}
