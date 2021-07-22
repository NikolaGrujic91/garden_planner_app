import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/plans_store.dart';
import '../model/plan.dart';
import '../widgets/save_icon_button.dart';
import '../widgets/text_field_bordered_numeric.dart';
import '../widgets/text_field_bordered.dart';
import '../widgets/preview_grid_view.dart';
import '../screens/main_screen.dart';

class AddPlanScreen extends StatefulWidget {
  static const String id = 'add_plan_screen';

  @override
  _AddPlanScreenState createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  String _name = 'New Plan';
  int _columns = 5;
  int _rows = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Plan'),
        actions: [
          SaveIconButton(
            callback: () async {
              await _savePlans();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldBordered(
              text: _name,
              hintText: 'Name',
              callback: _setName,
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Garden size',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                TextFieldBorderedNumeric(
                  text: _columns.toString(),
                  hintText: 'Columns',
                  callback: this._setColumns,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                TextFieldBorderedNumeric(
                  text: _rows.toString(),
                  hintText: 'Rows',
                  callback: this._setRows,
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Preview',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            PreviewGridView(
              columns: _columns,
              rows: _rows,
            ),
          ],
        ),
      ),
    );
  }

  void _setRows(int rows) {
    setState(() {
      _rows = rows;
    });
  }

  void _setColumns(int columns) {
    setState(() {
      _columns = columns;
    });
  }

  void _setName(String name) {
    setState(() {
      _name = name;
    });
  }

  Future<void> _savePlans() async {
    var plan = Plan(name: _name, rows: _rows, columns: _columns);
    var plansStore = Provider.of<PlansStore>(context, listen: false);
    plansStore.addPlan(plan);
    await plansStore.savePlans();
    Navigator.pushNamed(context, MainScreen.id);
  }
}
