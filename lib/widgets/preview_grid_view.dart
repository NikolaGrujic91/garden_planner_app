import 'package:flutter/material.dart';

class PreviewGridView extends StatelessWidget {
  const PreviewGridView({required this.columns, required this.rows});

  final int columns;
  final int rows;

  @override
  Widget build(BuildContext context) {
    // Calculate aspect ratio in order to make all grid cells always visible properly
    var size = MediaQuery.of(context).size;
    var aspectRatio = (size.width / columns) / ((size.height - (53 * 6)) / rows);

    return Expanded(
      child: GridView.count(
        crossAxisCount: columns,
        childAspectRatio: aspectRatio,
        children: List.generate(columns * rows, (index) {
          return Padding(
            padding: const EdgeInsets.all(0.5),
            child: ListTile(
              tileColor: Colors.green,
            ),
          );
        }),
      ),
    );
  }
}
