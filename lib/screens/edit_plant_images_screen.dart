import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/model/plant.dart';
import 'package:garden_planner_app/screens/edit_plant_screen.dart';
import 'package:garden_planner_app/screens/plants_screen.dart';
import 'package:garden_planner_app/screens/take_picture_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/icon_constants.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/image_carousel_slider.dart';
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
  late Plant _selectedPlant;
  late List<String>? _images;

  @override
  void initState() {
    super.initState();

    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    _selectedPlant = gardensStore.getSelectedPlant();
    _images = _selectedPlant.images;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Platform.isAndroid || Platform.isIOS;

    final floatingActionButtonTakePicture = FloatingActionButton(
      onPressed: () async {
        await Navigator.pushReplacementNamed(context, TakePictureScreen.id);
      },
      tooltip: 'Take picture',
      backgroundColor: kFloatingActionButtonColor,
      child: const Icon(kCameraIcon),
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
              if (_images != null && _images!.isNotEmpty)
                ImageCarouselSlider(
                  images: _images!,
                  height: 300,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
