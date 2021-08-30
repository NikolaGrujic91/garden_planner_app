import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/constants.dart';

/// This widget presents a preview of tiles grid while creating a garden
class PreviewGridView extends StatelessWidget {
  /// Creates a new instance
  const PreviewGridView({
    Key? key,
    required this.columns,
    required this.rows,
  }) : super(key: key);

  /// Number of columns
  final int columns;

  /// Number of rows
  final int rows;

  @override
  Widget build(BuildContext context) {
    // Calculate aspect ratio in order to make
    // all grid cells always visible properly
    final size = MediaQuery.of(context).size;
    final aspectRatio =
        (size.width / columns) / ((size.height - (53 * 6)) / rows);

    return Expanded(
      child: GridView.count(
        crossAxisCount: columns,
        childAspectRatio: aspectRatio,
        children: List.generate(columns * rows, (index) {
          return const Padding(
            padding: EdgeInsets.all(0.5),
            child: Material(
              child: ListTile(
                tileColor: kTilePlantColor,
              ),
            ),
          );
        }),
      ),
    );
  }
}
