import 'package:flutter/material.dart';
import 'package:garden_planner_app/screens/gardens_screen.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';

/// Calendar Screen Widget
class CalendarScreen extends StatelessWidget {
  /// Creates a new instance
  const CalendarScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'calendar_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        backScreenID: GardensScreen.id,
        title: 'Calendar',
      ),
      body: Container(),
    );
  }
}
