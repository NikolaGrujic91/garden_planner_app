import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_plan_screen.dart';
import '../screens/tiles_screen.dart';
import '../model/plans_store.dart';

class PlansList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PlansStore>(
      builder: (context, plansStore, child) {
        return Expanded(
          child: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(10.0),
              itemCount: plansStore.plans.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.grid_4x4),
                  title: Text(plansStore.plans[index].name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          plansStore.setSelectedPlanIndex(index);
                          await _showDeleteDialog(context);
                        },
                        icon: const Icon(Icons.delete),
                        tooltip: 'Delete plan',
                      ),
                      IconButton(
                        onPressed: () {
                          plansStore.setSelectedPlanIndex(index);
                          Navigator.pushNamed(context, EditPlanScreen.id);
                        },
                        icon: const Icon(Icons.edit),
                        tooltip: 'Edit plan',
                      )
                    ],
                  ),
                  onTap: () {
                    plansStore.setSelectedPlanIndex(index);
                    Navigator.pushNamed(context, TilesScreen.id);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<PlansStore>(
          builder: (context, plansStore, child) {
            return AlertDialog(
              title: Text('Confirm delete'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Delete the plan \"${plansStore.plans[plansStore.selectedPlanIndex].name}\"?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () async {
                    plansStore.removePlan(plansStore.plans[plansStore.selectedPlanIndex]);
                    await plansStore.savePlans();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
