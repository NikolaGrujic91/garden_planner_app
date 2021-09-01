import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:garden_planner_app/model/gardens_store.dart';
import 'package:garden_planner_app/screens/edit_garden_screen.dart';
import 'package:garden_planner_app/screens/tiles_screen.dart';
import 'package:garden_planner_app/utils/constants.dart';
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
    return Consumer<GardensStore>(
      builder: (context, gardensStore, child) {
        return Expanded(
          child: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: Container(
              color: kBackgroundColor,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(10),
                itemCount: gardensStore.gardens.length,
                itemBuilder: (context, index) {
                  return Material(
                    child: ListTile(
                      tileColor: kBackgroundColor,
                      leading: const Icon(Icons.grid_4x4),
                      title: StyledText(text: gardensStore.gardens[index].name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              gardensStore.selectedGardenIndex = index;
                              await _showDeleteDialog(
                                context,
                                gardensStore,
                              );
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
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDeleteDialog(
    BuildContext context,
    GardensStore gardensStore,
  ) async {
    final name = gardensStore.getSelectedGarden().name;
    final content = 'Delete the garden "$name"?';

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const StyledText(text: 'Confirm delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                StyledText(
                  text: content,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            if (Platform.isWindows)
              TextButton(
                onPressed: () async {
                  await _onDeletePressed(gardensStore);
                },
                child: const StyledText(text: 'Delete'),
              )
            else
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const StyledText(text: 'Cancel'),
              ),
            if (Platform.isWindows)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const StyledText(text: 'Cancel'),
              )
            else
              TextButton(
                onPressed: () async {
                  await _onDeletePressed(gardensStore);
                },
                child: const StyledText(text: 'Delete'),
              ),
          ],
        );
      },
    );
  }

  Future<void> _onDeletePressed(GardensStore gardensStore) async {
    gardensStore.removeGarden(gardensStore.getSelectedGarden());
    await gardensStore.saveGardens();

    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
