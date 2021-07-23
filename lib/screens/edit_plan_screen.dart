import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/plan.dart';
import '../model/plans_store.dart';
import '../widgets/save_icon_button.dart';
import '../widgets/text_field_bordered_numeric.dart';
import '../widgets/text_field_bordered.dart';
import '../widgets/preview_grid_view.dart';
import '../screens/main_screen.dart';
import '../utils/constants.dart';

class EditPlanScreen extends StatefulWidget {
  static const String id = 'edit_plan_screen';

  @override
  _EditPlanScreenState createState() => _EditPlanScreenState();
}

class _EditPlanScreenState extends State<EditPlanScreen> {
  String _name = 'New Plan';
  int _columns = 5;
  int _rows = 5;

  @override
  void initState() {
    super.initState();

    var plansStore = Provider.of<PlansStore>(context, listen: false);
    Plan selectedPlan = plansStore.plans[plansStore.selectedPlanIndex];
    _name = selectedPlan.name;
    _columns = selectedPlan.columns;
    _rows = selectedPlan.rows;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlansStore>(
      builder: (context, plansStore, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kAppBarBackgroundColor,
            title: Text('Edit $_name'),
            actions: [
              SaveIconButton(
                callback: () async {
                  await _updatePlan();
                },
              ),
            ],
          ),
          body: Container(
            color: kBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Garden name',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
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
                      const Text(
                        'X',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
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
          ),
        );
      },
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

  Future<void> _updatePlan() async {
    var plansStore = Provider.of<PlansStore>(context, listen: false);
    plansStore.updatePlan(name: _name, rows: _rows, columns: _columns);
    await plansStore.savePlans();
    Navigator.pushNamed(context, MainScreen.id);
  }
}
