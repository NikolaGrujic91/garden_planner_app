import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/gardens_store.dart';
import 'package:garden_planner_app/model/tile.dart';
import 'package:garden_planner_app/screens/edit_tile_plants_screen.dart';
import 'package:garden_planner_app/screens/edit_tile_type_screen.dart';
import 'package:garden_planner_app/utils/constants.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:provider/provider.dart';

/// This widget represents tiles grid of a garden
class TilesGrid extends StatelessWidget {
  /// Creates a new instance
  const TilesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GardensStore>(builder: (context, gardensStore, child) {
      final selectedGarden =
          gardensStore.gardens[gardensStore.selectedGardenIndex];
      final columns = selectedGarden.columns;
      final itemCount = selectedGarden.columns * selectedGarden.rows;
      final tiles = selectedGarden.tiles;

      return InteractiveViewer(
        minScale: 0.1,
        maxScale: 2,
        child: Center(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final drawTopBorder = ((index - columns) >= 0 &&
                      tiles[index - columns].type != TileType.home) ||
                  ((index - columns) < 0);
              final drawBottomBorder = ((index + columns) < tiles.length &&
                      tiles[index + columns].type != TileType.home) ||
                  ((index + columns) > tiles.length);
              final drawLeftBorder =
                  (index - 1) >= 0 && tiles[index - 1].type != TileType.home;
              final drawRightBorder = (index + 1) < tiles.length &&
                  tiles[index + 1].type != TileType.home;
              final isHomeTile = tiles[index].type == TileType.home;
              final isPlantTile = tiles[index].type == TileType.plant;

              return Container(
                decoration: isHomeTile
                    ? BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: drawTopBorder ? kTileHomeBorderWidth : 0.0,
                            color: drawTopBorder
                                ? kTileHomeBorderColor
                                : Colors.white,
                          ),
                          bottom: BorderSide(
                            width:
                                drawBottomBorder ? kTileHomeBorderWidth : 0.0,
                            color: drawBottomBorder
                                ? kTileHomeBorderColor
                                : Colors.white,
                          ),
                          left: BorderSide(
                            width: drawLeftBorder ? kTileHomeBorderWidth : 0.0,
                            color: drawLeftBorder
                                ? kTileHomeBorderColor
                                : Colors.white,
                          ),
                          right: BorderSide(
                            width: drawRightBorder ? kTileHomeBorderWidth : 0.0,
                            color: drawRightBorder
                                ? kTileHomeBorderColor
                                : Colors.white,
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

/// This widget extends base tile grid view cell to be draggable
class TileGridViewCellDragTarget extends StatelessWidget {
  /// Creates a new instance
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
        return true;
      },
      onAccept: (data) async {
        final plantType = stringToPlantType(data.toString());
        gardensStore.addPlant(tileIndex: tileIndex, plantType: plantType);
        await gardensStore.saveGardens();
        debugPrint(data.toString());
      },
    );
  }
}

/// This widget represents base tile grid view cell
class TileGridViewCell extends StatelessWidget {
  /// Creates a new instance
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
    final plantTypes = <PlantType>[];
    for (final plant in tiles[tileIndex].plants) {
      if (!plantTypes.contains(plant.type)) {
        plantTypes.add(plant.type);
      }
    }
    plantTypes.sort((a, b) => a.index.compareTo(b.index));

    final plantIcons = <Widget>[];
    for (final plantType in plantTypes) {
      plantIcons.add(plantTypeToIconData(plantType));
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: GestureDetector(
          onLongPress: () async {
            gardensStore.setSelectedTileIndex(tileIndex);
            await Navigator.pushReplacementNamed(
                context, EditTileTypeScreen.id);
          },
          onTap: () async {
            if (tiles[tileIndex].type == TileType.plant &&
                tiles[tileIndex].plants.isNotEmpty) {
              gardensStore.setSelectedTileIndex(tileIndex);
              await Navigator.pushReplacementNamed(
                  context, EditTilePlantsScreen.id);
            }
          },
          child: Container(
            color: tileTypeToTileColor(tiles[tileIndex].type),
            child: Wrap(
              spacing: 12, // space between two icons
              children: plantIcons,
            ),
          ),
        ),
      ),
    );
  }
}
