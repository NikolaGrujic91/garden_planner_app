import 'package:flutter/material.dart';
import 'package:garden_planner_app/widgets/garden_editor.dart';

/// Add Garden Screen Widget
class AddGardenScreen extends StatefulWidget {
  /// Creates a new instance
  const AddGardenScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'add_garden_screen';

  @override
  State<AddGardenScreen> createState() => _AddGardenScreenState();
}

class _AddGardenScreenState extends State<AddGardenScreen> {
  late String _name;
  late int _columns;
  late int _rows;

  @override
  void initState() {
    super.initState();

    _name = 'New Garden';
    _columns = 5;
    _rows = 5;
  }

  @override
  Widget build(BuildContext context) {
    return GardenEditor(
      name: _name,
      columns: _columns,
      rows: _rows,
      title: 'Edit $_name',
      isEditMode: false,
    );
  }
}
