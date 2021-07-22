import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:collection';
import '../screens/edit_tile_screen.dart';
import '../model/tile.dart';
import '../model/plan.dart';
import '../model/plans_store.dart';

class TilesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlansStore>(builder: (context, plansStore, child) {
      final Plan selectedPlan = plansStore.plans[plansStore.selectedPlanIndex];
      final int columns = selectedPlan.columns;
      final int rows = selectedPlan.rows;
      final int itemCount = selectedPlan.columns * selectedPlan.rows;
      final UnmodifiableListView<Tile> tiles = selectedPlan.tiles;

      // Calculate aspect ratio in order to make all grid cells always visible properly
      var size = MediaQuery.of(context).size;
      var aspectRatio = (size.width / columns) / ((size.height - 56) / rows);

      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: aspectRatio,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0.5),
            child: ListTile(
              leading: Icon(tiles[index].icon),
              title: Text('${tiles[index].plantName}\n${tiles[index].plantedDate}'),
              tileColor: tiles[index].tileColor,
              onTap: () async {
                plansStore.setSelectedTileIndex(index);
                Navigator.pushNamed(context, EditTileScreen.id);
              },
            ),
          );
        },
      );
    });
  }
}
