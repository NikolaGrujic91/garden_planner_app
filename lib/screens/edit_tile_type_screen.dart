import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tiles_screen.dart';
import '../widgets/save_icon_button.dart';
import '../model/plans_store.dart';
import '../model/enums.dart';
import '../model/plan.dart';
import '../model/tile.dart';
import '../utils/constants.dart';

class EditTileTypeScreen extends StatefulWidget {
  static const String id = 'edit_tile_type_screen';

  @override
  _EditTileTypeScreenState createState() => _EditTileTypeScreenState();
}

class _EditTileTypeScreenState extends State<EditTileTypeScreen> {
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
            backgroundColor: kAppBarBackgroundColor,
            leading: new IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, TilesScreen.id);
              },
              icon: new Icon(Icons.arrow_back_ios),
            ),
            title: Text('Edit tile type'),
            actions: [
              SaveIconButton(
                callback: () async {
                  await _updateTile();
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
                  Material(
                    child: RadioListTile<TileType>(
                      title: const Text('Plant'),
                      value: TileType.plant,
                      groupValue: _tileType,
                      onChanged: _setTileType,
                      tileColor: kBackgroundColor,
                    ),
                  ),
                  Material(
                    child: RadioListTile<TileType>(
                      title: const Text('Home'),
                      value: TileType.home,
                      groupValue: _tileType,
                      onChanged: _setTileType,
                      tileColor: kBackgroundColor,
                    ),
                  ),
                  Material(
                    child: RadioListTile<TileType>(
                      title: const Text('Path'),
                      value: TileType.path,
                      groupValue: _tileType,
                      onChanged: _setTileType,
                      tileColor: kBackgroundColor,
                    ),
                  ),
                  Material(
                    child: RadioListTile<TileType>(
                      title: const Text('None'),
                      value: TileType.none,
                      groupValue: _tileType,
                      onChanged: _setTileType,
                      tileColor: kBackgroundColor,
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

  void _setTileType(TileType? type) {
    setState(() {
      _tileType = type!;
    });
  }

  Future<void> _updateTile() async {
    var plansStore = Provider.of<PlansStore>(context, listen: false);
    plansStore.updateTile(type: _tileType, plantName: _plantName, plantedDate: _plantedDate);
    await plansStore.savePlans();
    Navigator.pushReplacementNamed(context, TilesScreen.id);
  }
}
