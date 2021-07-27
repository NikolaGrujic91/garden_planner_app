import 'package:flutter/material.dart';
import '../utils/constants.dart';

class TilesBottomBar extends StatelessWidget {
  const TilesBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Draggable(
            child: Icon(kTreeIcon),
            feedback: Icon(kTreeIcon),
            childWhenDragging: Icon(kTreeIcon),
            data: kTree,
          ),
          label: kTree,
          backgroundColor: kAppBarBackgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Draggable(
            child: Icon(kFruitIcon),
            feedback: Icon(kFruitIcon),
            childWhenDragging: Icon(kFruitIcon),
            data: kFruit,
          ),
          label: kFruit,
          backgroundColor: kAppBarBackgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Draggable(
            child: Icon(kVegetableIcon),
            feedback: Icon(kVegetableIcon),
            childWhenDragging: Icon(kVegetableIcon),
            data: kVegetable,
          ),
          label: kVegetable,
          backgroundColor: kAppBarBackgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Draggable(
            child: Icon(kFlowerIcon),
            feedback: Icon(kFlowerIcon),
            childWhenDragging: Icon(kFlowerIcon),
            data: kFlower,
          ),
          label: kFlower,
          backgroundColor: kAppBarBackgroundColor,
        ),
      ],
    );
  }
}
