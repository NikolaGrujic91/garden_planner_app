// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/color_constants.dart';

/// This widget presents a preview of tiles grid while creating a garden
class PreviewGridView extends StatelessWidget {
  /// Creates a new instance
  const PreviewGridView({
    super.key,
    required this.columns,
    required this.rows,
  });

  /// Number of columns
  final int columns;

  /// Number of rows
  final int rows;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: columns,
        children: List.generate(columns * rows, (index) {
          return Padding(
            padding: const EdgeInsets.all(0.5),
            child: Material(
              child: Container(
                color: kTilePlantColor,
              ),
            ),
          );
        }),
      ),
    );
  }
}
