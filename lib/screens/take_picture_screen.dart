import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/screens/edit_plant_images_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/icon_constants.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:provider/provider.dart';

/// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  /// Creates a new instance
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  /// Screen ID
  static const String id = 'take_picture_screen';

  /// Camera
  final CameraDescription camera;

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        backScreenID: EditPlantImagesScreen.id,
        title: 'Take picture',
      ),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until
      // the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Take the Picture in a try / catch block.
          try {
            final gardensStore =
                Provider.of<GardensStoreHive>(context, listen: false);

            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            // Store the automatically generated path to plant images
            gardensStore.addImage(image.path);
            await gardensStore.saveGardens();

            if (!mounted) return;
            await Navigator.pushReplacementNamed(
                context, EditPlantImagesScreen.id);
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        backgroundColor: kFloatingActionButtonColor,
        child: const Icon(kCameraIcon),
      ),
    );
  }
}
