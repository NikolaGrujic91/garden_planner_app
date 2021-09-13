import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/screens/edit_plant_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/icon_constants.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:provider/provider.dart';

/// This widget represents tiles grid of a garden
class PlantsList extends StatelessWidget {
  /// Creates a new instance
  PlantsList({Key? key}) : super(key: key);

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    final plants = gardensStore.getSelectedTile().plants;

    return Scrollbar(
      isAlwaysShown: true,
      controller: _scrollController,
      child: Container(
        color: kBackgroundColor,
        child: ListView.separated(
          controller: _scrollController,
          padding: const EdgeInsets.all(10),
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: plants.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey,
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: plantTypeToSvgPicture(plants[index].type),
                    title: Text(plants[index].name),
                    trailing: IconButton(
                      onPressed: () {
                        gardensStore.selectedPlantIndex = index;
                        Navigator.pushReplacementNamed(
                            context, EditPlantScreen.id);
                      },
                      icon: const Icon(kEditIcon),
                      tooltip: 'Edit plant',
                    ),
                  ),
                  if (plants[index].images != null &&
                      plants[index].images!.isNotEmpty)
                    CarouselSlider.builder(
                      options: CarouselOptions(height: 200),
                      itemCount: plants[index].images!.length,
                      itemBuilder: (
                        BuildContext context,
                        int imageIndex,
                        int pageViewIndex,
                      ) {
                        return Stack(
                          children: [
                            Image.file(
                              File(plants[index].images![imageIndex]),
                            ),
                            StyledText(
                              text:
                                  '${imageIndex + 1}/${plants[index].images!.length}',
                            ),
                          ],
                        );
                      },
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: StyledText(
                      text: plants[index].description,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: StyledText(
                      text: plants[index].plantedDate,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
