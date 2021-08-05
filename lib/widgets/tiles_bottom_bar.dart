import 'package:flutter/material.dart';

import '../utils/constants.dart';

class TilesBottomBar extends StatefulWidget {
  const TilesBottomBar({
    Key? key,
  }) : super(key: key);

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
            child: kTreeIcon40,
            feedback: kTreeIcon40,
            childWhenDragging: kTreeIcon40,
            data: kTree,
          ),
          label: kTree,
          backgroundColor: kAppBarBackgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Draggable(
            child: kFruitIcon40,
            feedback: kFruitIcon40,
            childWhenDragging: kFruitIcon40,
            data: kFruit,
          ),
          label: kFruit,
          backgroundColor: kAppBarBackgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Draggable(
            child: kVegetableIcon40,
            feedback: kVegetableIcon40,
            childWhenDragging: kVegetableIcon40,
            data: kVegetable,
          ),
          label: kVegetable,
          backgroundColor: kAppBarBackgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Draggable(
            child: kFlowerIcon40,
            feedback: kFlowerIcon40,
            childWhenDragging: kFlowerIcon40,
            data: kFlower,
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
