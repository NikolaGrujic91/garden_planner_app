import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/enums.dart';
import '../model/garden.dart';
import '../model/gardens_store.dart';
import '../model/plant.dart';
import '../model/tile.dart';
import '../screens/edit_tile_plants_screen.dart';
import '../screens/edit_tile_type_screen.dart';
import '../utils/constants.dart';
import '../utils/utility.dart';

class TilesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GardensStore>(builder: (context, gardensStore, child) {
      final Garden selectedGarden = gardensStore.gardens[gardensStore.selectedGardenIndex];
      final int columns = selectedGarden.columns;
      final int itemCount = selectedGarden.columns * selectedGarden.rows;
      final UnmodifiableListView<Tile> tiles = selectedGarden.tiles;

      return InteractiveViewer(
        minScale: 0.1,
        maxScale: 2.0,
        child: Center(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
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
                            width: drawTopBorder ? kTileHomeBorderWidth : 0.0,
                            color: drawTopBorder ? kTileHomeBorderColor : Colors.white,
                          ),
                          bottom: BorderSide(
                            width: drawBottomBorder ? kTileHomeBorderWidth : 0.0,
                            color: drawBottomBorder ? kTileHomeBorderColor : Colors.white,
                          ),
                          left: BorderSide(
                            width: drawLeftBorder ? kTileHomeBorderWidth : 0.0,
                            color: drawLeftBorder ? kTileHomeBorderColor : Colors.white,
                          ),
                          right: BorderSide(
                            width: drawRightBorder ? kTileHomeBorderWidth : 0.0,
                            color: drawRightBorder ? kTileHomeBorderColor : Colors.white,
                          ),
                        ),
                      )
                    : null,
                child: isPlantTile
                    ? TileGridViewCellDragTarget(
                        tiles: tiles,
                        tileIndex: index,
                        gardensStore: gardensStore,
                      )
                    : TileGridViewCell(
                        tiles: tiles,
                        tileIndex: index,
                        gardensStore: gardensStore,
                      ),
              );
            },
          ),
        ),
      );
    });
  }
}

class TileGridViewCellDragTarget extends StatelessWidget {
  const TileGridViewCellDragTarget({
    Key? key,
    required this.tiles,
    required this.tileIndex,
    required this.gardensStore,
  }) : super(key: key);

  final UnmodifiableListView<Tile> tiles;
  final int tileIndex;
  final GardensStore gardensStore;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return TileGridViewCell(
          tiles: tiles,
          tileIndex: tileIndex,
          gardensStore: gardensStore,
        );
      },
      onWillAccept: (data) {
        return tiles[tileIndex].plants.length < 4;
      },
      onAccept: (data) async {
        PlantType plantType = stringToPlantType(data.toString());
        gardensStore.addPlant(tileIndex: tileIndex, plantType: plantType);
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
    required this.tileIndex,
    required this.gardensStore,
  }) : super(key: key);

  final UnmodifiableListView<Tile> tiles;
  final int tileIndex;
  final GardensStore gardensStore;

  @override
  Widget build(BuildContext context) {
    List<Widget> plantIcons = <Widget>[];

    for (Plant plant in tiles[tileIndex].plants) {
      plantIcons.add(plantTypeToIconData(plant.type));
    }

    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: GestureDetector(
        child: Container(
          child: Wrap(
            spacing: 12, // space between two icons
            children: plantIcons,
          ),
          color: tileTypeToTileColor(tiles[tileIndex].type),
        ),
        onLongPress: () async {
          gardensStore.setSelectedTileIndex(tileIndex);
          Navigator.pushReplacementNamed(context, EditTileTypeScreen.id);
        },
        onTap: () async {
          if (tiles[tileIndex].type == TileType.plant && tiles[tileIndex].plants.isNotEmpty) {
            gardensStore.setSelectedTileIndex(tileIndex);
            Navigator.pushReplacementNamed(context, EditTilePlantsScreen.id);
          }
        },
      ),
    );
  }
}
