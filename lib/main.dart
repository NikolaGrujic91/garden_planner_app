import 'package:flutter/material.dart';
import 'package:garden_planner_app/model/gardens_store.dart';
import 'package:garden_planner_app/screens/add_garden_screen.dart';
import 'package:garden_planner_app/screens/edit_garden_screen.dart';
import 'package:garden_planner_app/screens/edit_tile_plants_screen.dart';
import 'package:garden_planner_app/screens/edit_tile_type_screen.dart';
import 'package:garden_planner_app/screens/main_screen.dart';
import 'package:garden_planner_app/screens/tiles_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const GardenPlannerApp());
}

/// This widget is the root of the application.
class GardenPlannerApp extends StatelessWidget {
  /// Creates a new instance
  const GardenPlannerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GardensStore>(
      create: (context) => GardensStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: MainScreen.id,
        routes: {
          MainScreen.id: (context) => MainScreen(),
          AddGardenScreen.id: (context) => AddGardenScreen(),
          EditGardenScreen.id: (context) => EditGardenScreen(),
          TilesScreen.id: (context) => TilesScreen(),
          EditTileTypeScreen.id: (context) => EditTileTypeScreen(),
          EditTilePlantsScreen.id: (context) => EditTilePlantsScreen(),
        },
      ),
    );
  }
}
