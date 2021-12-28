import 'package:flutter/material.dart';
import 'package:garden_planner_app/widgets/garden_editor.dart';

/// Add Garden Screen Widget
class AddGardenScreen extends StatelessWidget {
  /// Creates a new instance
  const AddGardenScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'add_garden_screen';

  String get _name => 'New Garden';

  int get _columns => 5;

  int get _rows => 5;

  @override
  Widget build(BuildContext context) {
    return GardenEditor.add(
      _name,
      _columns,
      _rows,
    );
  }
}
