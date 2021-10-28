import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/tile.dart';
import 'package:garden_planner_app/screens/edit_tile_type_screen.dart';
import 'package:garden_planner_app/screens/plants_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/style_constants.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:provider/provider.dart';

/// This widget represents tiles grid of a garden
class TilesGrid extends StatelessWidget {
  /// Creates a new instance
  const TilesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GardensStoreHive>(
      builder: (context, gardensStore, child) {
        final selectedGarden = gardensStore.getSelectedGarden();
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
                              width:
                                  drawLeftBorder ? kTileHomeBorderWidth : 0.0,
                              color: drawLeftBorder
                                  ? kTileHomeBorderColor
                                  : Colors.white,
                            ),
                            right: BorderSide(
                              width:
                                  drawRightBorder ? kTileHomeBorderWidth : 0.0,
                              color: drawRightBorder
                                  ? kTileHomeBorderColor
                                  : Colors.white,
                            ),
                          ),
                        )
                      : null,
                  child: isPlantTile
                      ? TileGridViewCellDragTarget(
                          tile: tiles[index],
                          tileIndex: index,
                          gardensStore: gardensStore,
                        )
                      : TileGridViewCell(
                          tile: tiles[index],
                          tileIndex: index,
                          gardensStore: gardensStore,
                        ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/// This widget extends base tile grid view cell to be a drag target
class TileGridViewCellDragTarget extends StatelessWidget {
  /// Creates a new instance
  const TileGridViewCellDragTarget({
    Key? key,
    required this.tile,
    required this.tileIndex,
    required this.gardensStore,
  }) : super(key: key);

  /// Tile
  final Tile tile;

  /// Tile index
  final int tileIndex;

  /// Gardens store
  final GardensStoreHive gardensStore;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return TileGridViewCell(
          tile: tile,
          tileIndex: tileIndex,
          gardensStore: gardensStore,
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) async {
        debugPrint(data.toString());

        final plantType = stringToPlantType(data.toString());
        gardensStore.addPlant(tileIndex: tileIndex, plantType: plantType);
        await gardensStore.saveGardens();
      },
    );
  }
}

/// This widget represents base tile grid view cell
class TileGridViewCell extends StatelessWidget {
  /// Creates a new instance
  const TileGridViewCell({
    Key? key,
    required this.tile,
    required this.tileIndex,
    required this.gardensStore,
  }) : super(key: key);

  /// Tile
  final Tile tile;

  /// Tile index
  final int tileIndex;

  /// Gardens store
  final GardensStoreHive gardensStore;

  @override
  Widget build(BuildContext context) {
    final plantTypesUnique = tile.plants.map((p) => p.type).toSet().toList()
      ..sort((a, b) => a.index.compareTo(b.index));

    final plantTypesCounter = <PlantType, int>{};

    for (final plant in tile.plants) {
      if (plantTypesCounter.containsKey(plant.type)) {
        plantTypesCounter.update(plant.type, (int value) {
          return plantTypesCounter[plant.type]! + 1;
        });
      } else {
        plantTypesCounter[plant.type] = 1;
      }
    }

    final plantIcons = <Widget>[];
    for (final plantType in plantTypesUnique) {
      plantIcons.add(
        Badge(
          badgeContent: Text(plantTypesCounter[plantType].toString()),
          child: plantTypeToSvgPicture(plantType),
        ),
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: GestureDetector(
          onLongPress: () async {
            if (tile.plants.isEmpty) {
              gardensStore.selectedTileIndex = tileIndex;
              await Navigator.pushReplacementNamed(
                context,
                EditTileTypeScreen.id,
              );
            }
          },
          onTap: () async {
            if (tile.type == TileType.plant && tile.plants.isNotEmpty) {
              gardensStore.selectedTileIndex = tileIndex;
              await Navigator.pushReplacementNamed(context, PlantsScreen.id);
            }
          },
          child: Container(
            color: tileTypeToTileColor(tile.type),
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
