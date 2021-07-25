import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:collection';
import '../screens/edit_tile_type_screen.dart';
import '../screens/edit_tile_plants_screen.dart';
import '../model/tile.dart';
import '../model/garden.dart';
import '../model/gardens_store.dart';
import '../model/enums.dart';
import '../utils/constants.dart';

class TilesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GardensStore>(builder: (context, gardensStore, child) {
      final Garden selectedGarden = gardensStore.gardens[gardensStore.selectedGardenIndex];
      final int columns = selectedGarden.columns;
      final int rows = selectedGarden.rows;
      final int itemCount = selectedGarden.columns * selectedGarden.rows;
      final UnmodifiableListView<Tile> tiles = selectedGarden.tiles;

      // Calculate aspect ratio in order to make all grid cells always visible properly
      var size = MediaQuery.of(context).size;
      var aspectRatio = (size.width / columns) / ((size.height - 56) / rows);

      return InteractiveViewer(
        minScale: 0.1,
        maxScale: 2.0,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: aspectRatio,
          ),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            bool drawTopBorder = ((index - columns) >= 0 && tiles[index - columns].type != TileType.home) || ((index - columns) < 0);
            bool drawBottomBorder = ((index + columns) < tiles.length && tiles[index + columns].type != TileType.home) || ((index + columns) > tiles.length);
            bool drawLeftBorder = (index - 1) >= 0 && tiles[index - 1].type != TileType.home;
            bool drawRightBorder = (index + 1) < tiles.length && tiles[index + 1].type != TileType.home;
            bool isHomeTile = tiles[index].type == TileType.home;

            return Container(
              decoration: isHomeTile
                  ? BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: drawTopBorder ? kHomeTileBorderWidth : 0.0,
                          color: drawTopBorder ? kHomeTileBorderColor : Colors.white,
                        ),
                        bottom: BorderSide(
                          width: drawBottomBorder ? kHomeTileBorderWidth : 0.0,
                          color: drawBottomBorder ? kHomeTileBorderColor : Colors.white,
                        ),
                        left: BorderSide(
                          width: drawLeftBorder ? kHomeTileBorderWidth : 0.0,
                          color: drawLeftBorder ? kHomeTileBorderColor : Colors.white,
                        ),
                        right: BorderSide(
                          width: drawRightBorder ? kHomeTileBorderWidth : 0.0,
                          color: drawRightBorder ? kHomeTileBorderColor : Colors.white,
                        ),
                      ),
                    )
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(0.5),
                child: ListTile(
                  leading: Icon(tiles[index].icon),
                  title: Text('${tiles[index].plantName}\n${tiles[index].plantedDate}'),
                  tileColor: tiles[index].tileColor,
                  onLongPress: () async {
                    gardensStore.setSelectedTileIndex(index);
                    Navigator.pushReplacementNamed(context, EditTileTypeScreen.id);
                  },
                  onTap: () async {
                    if (tiles[index].type == TileType.plant) {
                      gardensStore.setSelectedTileIndex(index);
                      Navigator.pushReplacementNamed(context, EditTilePlantsScreen.id);
                    }
                  },
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
