import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/gardens_list.dart';
import 'add_garden_screen.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: 'Gardens',
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.pushReplacementNamed(context, AddGardenScreen.id);
          },
          tooltip: 'Add garden',
          backgroundColor: kFloatingActionButtonColor,
          child: Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GardensList(),
          ],
        ));
  }
}
