import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/screens/main_screen.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/tiles_bottom_bar.dart';
import 'package:garden_planner_app/widgets/tiles_grid_view.dart';
import 'package:provider/provider.dart';

/// Tiles Screen Widget
class TilesScreen extends StatelessWidget {
  /// Creates a new instance
  const TilesScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'tiles_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<GardensStoreHive>(builder: (context, gardensStore, child) {
      return Scaffold(
        appBar: BaseAppBar(
          backScreenID: MainScreen.id,
          title: gardensStore.getSelectedGarden().name,
        ),
        body: const SafeArea(
          child: TilesGrid(),
        ),
        bottomNavigationBar: const TilesBottomBar(),
      );
    });
  }
}
