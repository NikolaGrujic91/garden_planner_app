import 'package:flutter/material.dart';
import 'add_plan_screen.dart';
import '../widgets/plans_list.dart';
import '../utils/constants.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarBackgroundColor,
          title: Text('Gardens'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.pushNamed(context, AddPlanScreen.id);
          },
          tooltip: 'Add garden',
          backgroundColor: kFloatingActionButtonColor,
          child: Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PlansList(),
          ],
        ));
  }
}
