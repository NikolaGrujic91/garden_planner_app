import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/plans_store.dart';
import 'screens/main_screen.dart';
import 'screens/add_plan_screen.dart';
import 'screens/edit_plan_screen.dart';
import 'screens/tiles_screen.dart';
import 'screens/edit_tile_screen.dart';

void main() {
  runApp(GardenPlannerApp());
}

class GardenPlannerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlansStore>(
      create: (context) => PlansStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: MainScreen.id,
        routes: {
          MainScreen.id: (context) => MainScreen(),
          AddPlanScreen.id: (context) => AddPlanScreen(),
          EditPlanScreen.id: (context) => EditPlanScreen(),
          TilesScreen.id: (context) => TilesScreen(),
          EditTileScreen.id: (context) => EditTileScreen(),
        },
      ),
    );
  }
}
