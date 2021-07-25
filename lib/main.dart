import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/gardens_store.dart';
import 'screens/main_screen.dart';
import 'screens/add_garden_screen.dart';
import 'screens/edit_garden_screen.dart';
import 'screens/tiles_screen.dart';
import 'screens/edit_tile_type_screen.dart';
import 'screens/edit_tile_plants_screen.dart';

void main() {
  runApp(GardenPlannerApp());
}

class GardenPlannerApp extends StatelessWidget {
  // This widget is the root of your application.
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
