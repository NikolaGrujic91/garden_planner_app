import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_garden_screen.dart';
import '../screens/tiles_screen.dart';
import '../model/gardens_store.dart';
import '../utils/constants.dart';

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
                      title: Text(gardensStore.gardens[index].name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              gardensStore.setSelectedGardenIndex(index);
                              await _showDeleteDialog(context);
                            },
                            icon: const Icon(Icons.delete),
                            tooltip: 'Delete garden',
                          ),
                          IconButton(
                            onPressed: () {
                              gardensStore.setSelectedGardenIndex(index);
                              Navigator.pushReplacementNamed(context, EditGardenScreen.id);
                            },
                            icon: const Icon(Icons.edit),
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
              title: Text('Confirm delete'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Delete the garden \"${gardensStore.gardens[gardensStore.selectedGardenIndex].name}\"?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () async {
                    gardensStore.removeGarden(gardensStore.gardens[gardensStore.selectedGardenIndex]);
                    await gardensStore.saveGardens();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
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
