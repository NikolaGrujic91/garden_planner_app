import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:collection';
import '../screens/edit_tile_type_screen.dart';
import '../screens/edit_tile_plants_screen.dart';
import '../model/plant.dart';
import '../model/tile.dart';
import '../model/garden.dart';
import '../model/gardens_store.dart';
import '../model/enums.dart';
import '../utils/constants.dart';
import '../utils/utility.dart';

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
      var aspectRatio = (size.width / columns) / ((size.height - 56 - 56) / rows);

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
            bool isPlantTile = tiles[index].type == TileType.plant;

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
              child: isPlantTile
                  ? TileGridViewCellDragTarget(
                      tiles: tiles,
                      index: index,
                      gardensStore: gardensStore,
                    )
                  : TileGridViewCell(
                      tiles: tiles,
                      index: index,
                      gardensStore: gardensStore,
                    ),
            );
          },
        ),
      );
    });
  }
}

class TileGridViewCellDragTarget extends StatelessWidget {
  const TileGridViewCellDragTarget({
    Key? key,
    required this.tiles,
    required this.index,
    required this.gardensStore,
  }) : super(key: key);

  final UnmodifiableListView<Tile> tiles;
  final int index;
  final GardensStore gardensStore;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return TileGridViewCell(
          tiles: tiles,
          index: index,
          gardensStore: gardensStore,
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) async {
        PlantType plantType = stringToPlantType(data.toString());
        gardensStore.addPlant(tileIndex: index, plantType: plantType);
        await gardensStore.saveGardens();
        print(data);
      },
    );
  }
}

class TileGridViewCell extends StatelessWidget {
  const TileGridViewCell({
    Key? key,
    required this.tiles,
    required this.index,
    required this.gardensStore,
  }) : super(key: key);

  final UnmodifiableListView<Tile> tiles;
  final int index;
  final GardensStore gardensStore;

  @override
  Widget build(BuildContext context) {
    List<Widget> plantIcons = <Widget>[];

    for (Plant plant in tiles[index].plants) {
      plantIcons.add(Icon(plantTypeToIconData(plant.type)));
    }

    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: ListTile(
        leading: Icon(tileTypeToIconData(tiles[index].type)),
        title: Wrap(
          spacing: 12, // space between two icons
          children: plantIcons,
        ),
        tileColor: tileTypeToTileColor(tiles[index].type),
        onLongPress: () async {
          gardensStore.setSelectedTileIndex(index);
          Navigator.pushReplacementNamed(context, EditTileTypeScreen.id);
        },
        onTap: () async {
          if (tiles[index].type == TileType.plant && tiles[index].plants.length > 0) {
            gardensStore.setSelectedTileIndex(index);
            Navigator.pushReplacementNamed(context, EditTilePlantsScreen.id);
          }
        },
      ),
    );
  }
}
