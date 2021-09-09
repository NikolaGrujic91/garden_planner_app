import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/screens/edit_plant_screen.dart';
import 'package:garden_planner_app/utils/constants.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:provider/provider.dart';

/// This widget represents tiles grid of a garden
class PlantsList extends StatelessWidget {
  /// Creates a new instance
  const PlantsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    final plants = gardensStore.getSelectedTile().plants;

    return Container(
      color: kBackgroundColor,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    const StyledText(
                      text: 'Name:',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    StyledText(
                      text: plants[index].name,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        gardensStore.selectedPlantIndex = index;
                        Navigator.pushReplacementNamed(
                            context, EditPlantScreen.id);
                      },
                      icon: const Icon(kEditIcon),
                      tooltip: 'Edit plant',
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const StyledText(
                      text: 'Description:',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    StyledText(
                      text: plants[index].description,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const StyledText(
                      text: 'Planted:',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    StyledText(
                      text: plants[index].plantedDate,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
