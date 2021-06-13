import 'package:flutter/material.dart';

class PreviewGridView extends StatelessWidget {
  const PreviewGridView({required this.width, required this.height});

  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: width,
        childAspectRatio: 1.5,
        children: List.generate(width * height, (index) {
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
