import 'package:flutter/material.dart';
import 'package:garden_planner_app/screens/tiles_screen.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/plants_list.dart';

/// Plants Screen Widget
class PlantsScreen extends StatelessWidget {
  /// Creates a new instance
  const PlantsScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'plants_screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBar(
        backScreenID: TilesScreen.id,
        title: 'Plants',
      ),
      body: SafeArea(
        child: PlantsList(),
      ),
    );
  }
}
