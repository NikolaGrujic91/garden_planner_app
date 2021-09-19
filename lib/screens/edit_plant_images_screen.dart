import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/screens/edit_plant_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/widgets/alert_dialogs.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/image_carousel_slider.dart';
import 'package:garden_planner_app/widgets/styled_outlined_button.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:image_picker/image_picker.dart';
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
    return Scaffold(
      appBar: const BaseAppBar(
        backScreenID: EditPlantScreen.id,
        title: 'Edit plant images',
      ),
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
                  StyledOutlinedButton(
                    text: 'Remove Current Photo',
                    onPressed: _showDeleteDialog,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  StyledOutlinedButton(
                    text: 'Choose From Gallery',
                    onPressed: _onPickImagesPressed,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  StyledOutlinedButton(
                    text: 'Take Photo',
                    onPressed: _onCapturePhotoPressed,
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

  Future<void> _onPickImagesPressed() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage();
    await _saveImages(images);
  }

  Future<void> _onCapturePhotoPressed() async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      await _saveImages([photo]);
    }
  }

  Future<void> _saveImages(List<XFile>? images) async {
    if (images == null || images.isEmpty) {
      return;
    }

    final imagePaths = images.map((image) => image.path).toList();

    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false)
      ..addImages(imagePaths);
    await gardensStore.saveGardens();
  }
}
