// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/screens/add_garden_screen.dart';
import 'package:garden_planner_app/screens/calendar_screen.dart';
import 'package:garden_planner_app/screens/edit_garden_screen.dart';
import 'package:garden_planner_app/screens/edit_plant_images_screen.dart';
import 'package:garden_planner_app/screens/edit_plant_screen.dart';
import 'package:garden_planner_app/screens/edit_tile_type_screen.dart';
import 'package:garden_planner_app/screens/gardens_screen.dart';
import 'package:garden_planner_app/screens/plants_screen.dart';
import 'package:garden_planner_app/screens/tiles_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const GardenPlannerApp());
}

/// This widget is the root of the application.
class GardenPlannerApp extends StatelessWidget {
  /// Creates a new instance
  const GardenPlannerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GardensStoreHive>(
      create: (context) => GardensStoreHive(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: GardensScreen.id,
        routes: {
          GardensScreen.id: (context) => const GardensScreen(),
          AddGardenScreen.id: (context) => const AddGardenScreen(),
          EditGardenScreen.id: (context) => const EditGardenScreen(),
          CalendarScreen.id: (context) => const CalendarScreen(),
          TilesScreen.id: (context) => const TilesScreen(),
          PlantsScreen.id: (context) => const PlantsScreen(),
          EditTileTypeScreen.id: (context) => const EditTileTypeScreen(),
          EditPlantScreen.id: (context) => const EditPlantScreen(),
          EditPlantImagesScreen.id: (context) => const EditPlantImagesScreen(),
        },
      ),
    );
  }
}
