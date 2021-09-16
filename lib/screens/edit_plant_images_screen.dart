import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/screens/edit_plant_screen.dart';
import 'package:garden_planner_app/screens/take_picture_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/icon_constants.dart';
import 'package:garden_planner_app/widgets/alert_dialogs.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/image_carousel_slider.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:provider/provider.dart';

/// Edit Plant Images Screen
class EditPlantImagesScreen extends StatefulWidget {
  /// Creates a new instance
  const EditPlantImagesScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'edit_plant_images_screen';

  @override
  _EditPlantImagesScreenState createState() => _EditPlantImagesScreenState();
}

class _EditPlantImagesScreenState extends State<EditPlantImagesScreen> {
  @override
  Widget build(BuildContext context) {
    final isMobile = Platform.isAndroid || Platform.isIOS;

    final floatingActionButtonTakePicture = FloatingActionButton(
      onPressed: () async {
        await Navigator.pushReplacementNamed(context, TakePictureScreen.id);
      },
      tooltip: 'Take picture',
      backgroundColor: kFloatingActionButtonColor,
      child: const Icon(kAddIcon),
    );

    return Scaffold(
      appBar: const BaseAppBar(
        backScreenID: EditPlantScreen.id,
        title: 'Edit plant images',
      ),
      floatingActionButton: isMobile ? floatingActionButtonTakePicture : null,
      body: Container(
        color: kBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Consumer<GardensStoreHive>(
                  builder: (context, gardensStore, child) {
                final selectedPlant = gardensStore.getSelectedPlant();
                final images = selectedPlant.images;

                if (images != null && images.isNotEmpty) {
                  return ImageCarouselSlider(
                    images: images,
                    height: 300,
                  );
                } else {
                  return const StyledText(text: 'No images');
                }
              }),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        await _showDeleteDialog();
                      },
                      child: const Text(
                        'Delete Image',
                        style: TextStyle(
                          fontFamily: 'Roboto Sans',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog() async {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    final selectedPlant = gardensStore.getSelectedPlant();
    final images = selectedPlant.images;

    if (images == null || images.isEmpty) {
      return;
    }

    const content = 'Delete the image?';

    return showDeleteDialog(context, content, _onDeletePressed);
  }

  Future<void> _onDeletePressed() async {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false)
      ..removeSelectedImage();
    await gardensStore.saveGardens();

    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
