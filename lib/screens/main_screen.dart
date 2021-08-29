import 'package:flutter/material.dart';
import 'package:garden_planner_app/screens/add_garden_screen.dart';
import 'package:garden_planner_app/utils/constants.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/gardens_list.dart';

/// Main Screen Widget
class MainScreen extends StatelessWidget {
  /// Creates a new instance
  const MainScreen({Key? key}) : super(key: key);

  /// Tiles Screen ID
  static const String id = 'main_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Grow',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushReplacementNamed(context, AddGardenScreen.id);
        },
        tooltip: 'Add garden',
        backgroundColor: kFloatingActionButtonColor,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          GardensList(),
        ],
      ),
    );
  }
}
