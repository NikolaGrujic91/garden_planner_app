import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/model/garden.dart';
import 'package:garden_planner_app/screens/main_screen.dart';
import 'package:garden_planner_app/utils/constants.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/preview_grid_view.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:garden_planner_app/widgets/text_field_bordered.dart';
import 'package:garden_planner_app/widgets/text_field_bordered_numeric.dart';
import 'package:provider/provider.dart';

/// Add Garden Screen Widget
class AddGardenScreen extends StatefulWidget {
  /// Creates a new instance
  const AddGardenScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'add_garden_screen';

  @override
  _AddGardenScreenState createState() => _AddGardenScreenState();
}

class _AddGardenScreenState extends State<AddGardenScreen> {
  String _name = 'New Garden';
  int _columns = 5;
  int _rows = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backScreenID: MainScreen.id,
        title: 'Add Garden',
        saveCallback: _save,
      ),
      body: Container(
        color: kBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldBordered(
                text: _name,
                hintText: 'Garden name',
                callback: _setName,
              ),
              const SizedBox(
                height: 20,
              ),
              const StyledText(
                text: 'Garden size',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextFieldBorderedNumeric(
                    text: _rows.toString(),
                    hintText: 'Rows',
                    callback: _setRows,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const StyledText(
                    text: 'X',
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextFieldBorderedNumeric(
                    text: _columns.toString(),
                    hintText: 'Columns',
                    callback: _setColumns,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
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

  Future<void> _save() async {
    final garden = Garden(name: _name, rows: _rows, columns: _columns);
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false)
      ..addGarden(garden);
    await gardensStore.saveGardens();

    if (!mounted) return;
    await Navigator.pushReplacementNamed(context, MainScreen.id);
  }
}
