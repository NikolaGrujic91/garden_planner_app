// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

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
  const GardensList({super.key});

  @override
  State<GardensList> createState() => _GardensListState();
}

class _GardensListState extends State<GardensList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        child: ColoredBox(
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
                      leading: Icon(
                        kGridIcon,
                        color: kRedColor,
                      ),
                      title: StyledText(text: gardensStore.gardens[index].name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              gardensStore.selectedGardenIndex = index;
                              Navigator.pushReplacementNamed(
                                context,
                                EditGardenScreen.id,
                              );
                            },
                            icon: Icon(kEditIcon),
                            tooltip: 'Edit garden',
                          ),
                          IconButton(
                            onPressed: () async {
                              gardensStore.selectedGardenIndex = index;
                              await _showDeleteDialog();
                            },
                            icon: Icon(kDeleteIcon, size: 20),
                            tooltip: 'Delete garden',
                          ),
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
            },
          ),
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
