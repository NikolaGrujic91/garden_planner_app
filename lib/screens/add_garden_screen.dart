import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/garden.dart';
import '../model/gardens_store.dart';
import '../screens/main_screen.dart';
import '../utils/constants.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/preview_grid_view.dart';
import '../widgets/styled_text.dart';
import '../widgets/text_field_bordered.dart';
import '../widgets/text_field_bordered_numeric.dart';

class AddGardenScreen extends StatefulWidget {
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const StyledText(
                text: 'garden name',
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
              const StyledText(
                text: 'garden size',
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
                  const StyledText(
                    text: 'X',
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
              const StyledText(
                text: 'preview',
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
    var garden = Garden(name: _name, rows: _rows, columns: _columns);
    var gardensStore = Provider.of<GardensStore>(context, listen: false);
    gardensStore.addGarden(garden);
    await gardensStore.saveGardens();
    Navigator.pushReplacementNamed(context, MainScreen.id);
  }
}
