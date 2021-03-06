// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/screens/edit_plant_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/icon_constants.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:garden_planner_app/widgets/image_carousel_slider.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:provider/provider.dart';

/// This widget represents tiles grid of a garden
class PlantsList extends StatelessWidget {
  /// Creates a new instance
  PlantsList({super.key});

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    final plants = gardensStore.getSelectedTile().plants;

    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: ColoredBox(
        color: kBackgroundColor,
        child: ListView.separated(
          controller: _scrollController,
          separatorBuilder: (context, index) => const Divider(),
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          itemCount: plants.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: plantTypeToSvgPicture60(plants[index].type),
                  title: Text(plants[index].name),
                  trailing: IconButton(
                    onPressed: () {
                      gardensStore.selectedPlantIndex = index;
                      Navigator.pushReplacementNamed(
                        context,
                        EditPlantScreen.id,
                      );
                    },
                    icon: Icon(kEditIcon),
                    tooltip: 'Edit plant',
                  ),
                  subtitle: StyledText(text: plants[index].description),
                ),
                Row(
                  children: [
                    if (plants[index].images != null &&
                        plants[index].images!.isNotEmpty)
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ImageCarouselSlider(
                          images: plants[index].images!,
                          height: 300,
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
