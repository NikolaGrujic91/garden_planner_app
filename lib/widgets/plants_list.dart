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
          separatorBuilder: (context, index) => const Divider(),
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          itemCount: plants.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    plantTypeToSvgPicture(plants[index].type),
                    Text(plants[index].name),
                    const Spacer(),
                    IconButton(
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
                  ],
                ),
                SubtitleRow(text: plants[index].description),
                SubtitleRow(text: plants[index].plantedDate),
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

/// This widget represents subtitle row
class SubtitleRow extends StatelessWidget {
  /// Creates a new instance
  const SubtitleRow({
    Key? key,
    required this.text,
  }) : super(key: key);

  /// Text to be displayed
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            bottom: 10,
          ),
          child: StyledText(text: text),
        ),
      ],
    );
  }
}
