import 'package:flutter/material.dart';
import 'add_plan_screen.dart';
import '../widgets/plans_list.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Plans'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.pushNamed(context, AddPlanScreen.id);
          },
          tooltip: 'Add plan',
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
