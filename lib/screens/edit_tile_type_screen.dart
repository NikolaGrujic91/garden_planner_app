import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tiles_screen.dart';
import '../widgets/base_app_bar.dart';
import '../model/gardens_store.dart';
import '../model/enums.dart';
import '../model/garden.dart';
import '../model/tile.dart';
import '../utils/constants.dart';

class EditTileTypeScreen extends StatefulWidget {
  static const String id = 'edit_tile_type_screen';

  @override
  _EditTileTypeScreenState createState() => _EditTileTypeScreenState();
}

class _EditTileTypeScreenState extends State<EditTileTypeScreen> {
  TileType _tileType = TileType.plant;

  @override
  void initState() {
    super.initState();

    var gardensStore = Provider.of<GardensStore>(context, listen: false);
    Garden selectedGarden = gardensStore.gardens[gardensStore.selectedGardenIndex];
    Tile selectedTile = selectedGarden.tiles[gardensStore.selectedTileIndex];
    _tileType = selectedTile.type;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GardensStore>(
      builder: (context, gardensStore, child) {
        return Scaffold(
          appBar: BaseAppBar(
            backScreenID: TilesScreen.id,
            title: 'Edit tile type',
            saveCallback: _save,
            appBar: AppBar(),
          ),
          body: Container(
            color: kBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Material(
                    child: RadioListTile<TileType>(
                      title: const Text(kPlant),
                      value: TileType.plant,
                      groupValue: _tileType,
                      onChanged: _setTileType,
                      tileColor: kBackgroundColor,
                    ),
                  ),
                  Material(
                    child: RadioListTile<TileType>(
                      title: const Text(kHome),
                      value: TileType.home,
                      groupValue: _tileType,
                      onChanged: _setTileType,
                      tileColor: kBackgroundColor,
                    ),
                  ),
                  Material(
                    child: RadioListTile<TileType>(
                      title: const Text(kPath),
                      value: TileType.path,
                      groupValue: _tileType,
                      onChanged: _setTileType,
                      tileColor: kBackgroundColor,
                    ),
                  ),
                  Material(
                    child: RadioListTile<TileType>(
                      title: const Text(kNone),
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

  Future<void> _save() async {
    var gardensStore = Provider.of<GardensStore>(context, listen: false);
    gardensStore.updateSelectedTileType(type: _tileType);
    await gardensStore.saveGardens();
    Navigator.pushReplacementNamed(context, TilesScreen.id);
  }
}
