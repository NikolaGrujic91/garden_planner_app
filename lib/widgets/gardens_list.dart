import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/gardens_store.dart';
import '../screens/edit_garden_screen.dart';
import '../screens/tiles_screen.dart';
import '../utils/constants.dart';
import '../widgets/styled_text.dart';

class GardensList extends StatelessWidget {
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
                padding: EdgeInsets.all(10.0),
                itemCount: gardensStore.gardens.length,
                itemBuilder: (context, index) {
                  return Material(
                    child: ListTile(
                      tileColor: kBackgroundColor,
                      leading: Icon(Icons.grid_4x4),
                      title: StyledText(text: gardensStore.gardens[index].name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              gardensStore.setSelectedGardenIndex(index);
                              await _showDeleteDialog(context);
                            },
                            icon: const Icon(kDeleteIcon),
                            tooltip: 'Delete garden',
                          ),
                          IconButton(
                            onPressed: () {
                              gardensStore.setSelectedGardenIndex(index);
                              Navigator.pushReplacementNamed(context, EditGardenScreen.id);
                            },
                            icon: const Icon(kEditIcon),
                            tooltip: 'Edit garden',
                          )
                        ],
                      ),
                      onTap: () {
                        gardensStore.setSelectedGardenIndex(index);
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

  Future<void> _showDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<GardensStore>(
          builder: (context, gardensStore, child) {
            return AlertDialog(
              title: StyledText(text: 'Confirm delete'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    StyledText(text: 'Delete the garden \"${gardensStore.gardens[gardensStore.selectedGardenIndex].name}\"?'),
                  ],
                ),
              ),
              actions: <Widget>[
                if (Platform.isWindows)
                  TextButton(
                    child: const StyledText(text: 'Delete'),
                    onPressed: () async {
                      gardensStore.removeGarden(gardensStore.gardens[gardensStore.selectedGardenIndex]);
                      await gardensStore.saveGardens();
                      Navigator.of(context).pop();
                    },
                  )
                else
                  TextButton(
                    child: const StyledText(text: 'Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                if (Platform.isWindows)
                  TextButton(
                    child: const StyledText(text: 'Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                else
                  TextButton(
                    child: const StyledText(text: 'Delete'),
                    onPressed: () async {
                      gardensStore.removeGarden(gardensStore.gardens[gardensStore.selectedGardenIndex]);
                      await gardensStore.saveGardens();
                      Navigator.of(context).pop();
                    },
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
