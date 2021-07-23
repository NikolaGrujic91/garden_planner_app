import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/plans_store.dart';
import '../widgets/tiles_grid_view.dart';
import '../screens/main_screen.dart';
import '../utils/constants.dart';

class TilesScreen extends StatelessWidget {
  static const String id = 'tiles_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<PlansStore>(builder: (context, plansStore, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarBackgroundColor,
          leading: new IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, MainScreen.id);
            },
            icon: new Icon(Icons.arrow_back_ios),
          ),
          title: Text(plansStore.plans[plansStore.selectedPlanIndex].name),
        ),
        body: TilesGrid(),
      );
    });
  }
}
