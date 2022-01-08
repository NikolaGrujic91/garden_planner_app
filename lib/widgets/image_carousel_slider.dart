// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:provider/provider.dart';

/// This widget represents reusable image carousel slider
class ImageCarouselSlider extends StatelessWidget {
  /// Creates a new instance
  const ImageCarouselSlider({
    Key? key,
    required this.images,
    required this.height,
  }) : super(key: key);

  /// Paths to images to be shown in the carousel
  final List<String> images;

  /// Set carousel height
  final double height;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: height,

        /// Carousel covers 100% of available viewport
        viewportFraction: 1,
        onPageChanged: (int index, CarouselPageChangedReason reason) {
          Provider.of<GardensStoreHive>(context, listen: false)
              .selectedImageIndex = index;
        },
      ),
      itemCount: images.length,
      itemBuilder: (
        BuildContext context,
        int imageIndex,
        int pageViewIndex,
      ) {
        return Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Image.file(
              File(images[imageIndex]),

              /// Set width that is way larger that screen width
              width: MediaQuery.of(context).size.width,

              /// Set fitWidth so that image covers full width
              fit: BoxFit.fitWidth,
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: StyledText(
                text: '${imageIndex + 1}/${images.length}',
              ),
            ),
          ],
        );
      },
    );
  }
}
