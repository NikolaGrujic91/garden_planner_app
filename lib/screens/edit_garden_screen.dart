import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/widgets/garden_editor.dart';
import 'package:provider/provider.dart';

/// Edit Garden Screen Widget
class EditGardenScreen extends StatefulWidget {
  /// Creates a new instance
  const EditGardenScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'edit_garden_screen';

  @override
  State<EditGardenScreen> createState() => _EditGardenScreenState();
}

class _EditGardenScreenState extends State<EditGardenScreen> {
  late String _name;
  late int _columns;
  late int _rows;

  @override
  void initState() {
    super.initState();

    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    final selectedGarden = gardensStore.getSelectedGarden();
    _name = selectedGarden.name;
    _columns = selectedGarden.columns;
    _rows = selectedGarden.rows;
  }

  @override
  Widget build(BuildContext context) {
    return GardenEditor(
      name: _name,
      columns: _columns,
      rows: _rows,
      title: 'Edit $_name',
      isEditMode: true,
    );
  }
}
