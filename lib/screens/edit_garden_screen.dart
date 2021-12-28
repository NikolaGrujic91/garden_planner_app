import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/widgets/garden_editor.dart';
import 'package:provider/provider.dart';

/// Edit Garden Screen Widget
class EditGardenScreen extends StatelessWidget {
  /// Creates a new instance
  const EditGardenScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'edit_garden_screen';

  @override
  Widget build(BuildContext context) {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    final selectedGarden = gardensStore.getSelectedGarden();

    return GardenEditor.edit(
      selectedGarden.name,
      selectedGarden.columns,
      selectedGarden.rows,
    );
  }
}
