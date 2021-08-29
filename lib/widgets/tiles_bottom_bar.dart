import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/constants.dart';

/// This widget represents bottom bar with draggable items
class TilesBottomBar extends StatefulWidget {
  /// Creates a new instance
  const TilesBottomBar({Key? key}) : super(key: key);

  @override
  _TilesBottomBarState createState() => _TilesBottomBarState();
}

class _TilesBottomBarState extends State<TilesBottomBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTap,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Draggable(
            feedback: kTreeIcon40,
            data: kTree,
            childWhenDragging: kTreeIcon40,
            child: kTreeIcon40,
          ),
          label: kTree,
          backgroundColor: kAppBarBackgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Draggable(
            feedback: kFruitIcon40,
            data: kFruit,
            childWhenDragging: kFruitIcon40,
            child: kFruitIcon40,
          ),
          label: kFruit,
          backgroundColor: kAppBarBackgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Draggable(
            feedback: kVegetableIcon40,
            data: kVegetable,
            childWhenDragging: kVegetableIcon40,
            child: kVegetableIcon40,
          ),
          label: kVegetable,
          backgroundColor: kAppBarBackgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Draggable(
            feedback: kFlowerIcon40,
            data: kFlower,
            childWhenDragging: kFlowerIcon40,
            child: kFlowerIcon40,
          ),
          label: kFlower,
          backgroundColor: kAppBarBackgroundColor,
        ),
      ],
    );
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
