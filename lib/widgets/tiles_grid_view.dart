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
      final int itemCount = selectedPlan.columns * selectedPlan.rows;
      final UnmodifiableListView<Tile> tiles = selectedPlan.tiles;

      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: 1.5,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0.5),
            child: ListTile(
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
