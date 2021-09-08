import 'dart:io' show Platform;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/screens/add_garden_screen.dart';
import 'package:garden_planner_app/screens/edit_garden_screen.dart';
import 'package:garden_planner_app/screens/edit_tile_plants_screen.dart';
import 'package:garden_planner_app/screens/edit_tile_type_screen.dart';
import 'package:garden_planner_app/screens/main_screen.dart';
import 'package:garden_planner_app/screens/take_picture_screen.dart';
import 'package:garden_planner_app/screens/tiles_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  if (Platform.isAndroid || Platform.isIOS) {
    // Ensure that plugin services are initialized so that `availableCameras()`
    // can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    runApp(GardenPlannerApp(camera: cameras.first));
  } else {
    runApp(const GardenPlannerApp(camera: null));
  }
}

/// This widget is the root of the application.
class GardenPlannerApp extends StatelessWidget {
  /// Creates a new instance
  const GardenPlannerApp({
    Key? key,
    required this.camera,
  }) : super(key: key);

  /// Camera
  final CameraDescription? camera;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GardensStoreHive>(
      create: (context) => GardensStoreHive(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: MainScreen.id,
        routes: {
          MainScreen.id: (context) => const MainScreen(),
          AddGardenScreen.id: (context) => const AddGardenScreen(),
          EditGardenScreen.id: (context) => const EditGardenScreen(),
          TilesScreen.id: (context) => const TilesScreen(),
          EditTileTypeScreen.id: (context) => const EditTileTypeScreen(),
          EditTilePlantsScreen.id: (context) => const EditTilePlantsScreen(),
          TakePictureScreen.id: (context) => TakePictureScreen(camera: camera!)
        },
      ),
    );
  }
}
