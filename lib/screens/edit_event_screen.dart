import 'package:flutter/material.dart';
import 'package:garden_planner_app/screens/edit_plant_screen.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';

/// Main Screen Widget
class EditEventScreen extends StatelessWidget {
  /// Creates a new instance
  const EditEventScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'edit_event_screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBar(
        backScreenID: EditPlantScreen.id,
        title: 'Edit Event',
      ),
      body: Text('Edit Event'),
    );
  }
}
