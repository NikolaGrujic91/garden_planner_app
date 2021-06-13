import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/plans_store.dart';
import '../widgets/tiles_grid_view.dart';

class TilesScreen extends StatelessWidget {
  static const String id = 'tiles_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<PlansStore>(builder: (context, plansStore, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(plansStore.plans[plansStore.selectedPlanIndex].name),
        ),
        body: TilesGrid(),
      );
    });
  }
}
