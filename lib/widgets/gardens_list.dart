import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/screens/edit_garden_screen.dart';
import 'package:garden_planner_app/screens/tiles_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/icon_constants.dart';
import 'package:garden_planner_app/widgets/alert_dialogs.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:provider/provider.dart';

/// This widget represents list of gardens
class GardensList extends StatefulWidget {
  /// Creates a new instance
  const GardensList({Key? key}) : super(key: key);

  @override
  _GardensListState createState() => _GardensListState();
}

class _GardensListState extends State<GardensList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        child: Container(
          color: kBackgroundColor,
          child: Consumer<GardensStoreHive>(
              builder: (context, gardensStore, child) {
            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(10),
              itemCount: gardensStore.gardens.length,
              itemBuilder: (context, index) {
                return Material(
                  child: ListTile(
                    tileColor: kBackgroundColor,
                    leading: const Icon(kGridIcon),
                    title: StyledText(text: gardensStore.gardens[index].name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            gardensStore.selectedGardenIndex = index;
                            await _showDeleteDialog();
                          },
                          icon: const Icon(kDeleteIcon),
                          tooltip: 'Delete garden',
                        ),
                        IconButton(
                          onPressed: () {
                            gardensStore.selectedGardenIndex = index;
                            Navigator.pushReplacementNamed(
                                context, EditGardenScreen.id);
                          },
                          icon: const Icon(kEditIcon),
                          tooltip: 'Edit garden',
                        )
                      ],
                    ),
                    onTap: () {
                      gardensStore.selectedGardenIndex = index;
                      Navigator.pushReplacementNamed(context, TilesScreen.id);
                    },
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog() async {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    final name = gardensStore.getSelectedGarden().name;
    final content = 'Delete the garden "$name"?';

    return showDeleteDialog(context, content, _onDeletePressed);
  }

  Future<void> _onDeletePressed() async {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false)
      ..removeSelectedGarden();
    await gardensStore.saveGardens();

    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
