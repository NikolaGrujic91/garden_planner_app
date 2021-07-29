import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/garden.dart';
import '../model/gardens_store.dart';
import '../screens/main_screen.dart';
import '../utils/constants.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/preview_grid_view.dart';
import '../widgets/text_field_bordered.dart';
import '../widgets/text_field_bordered_numeric.dart';

class EditGardenScreen extends StatefulWidget {
  static const String id = 'edit_garden_screen';

  @override
  _EditGardenScreenState createState() => _EditGardenScreenState();
}

class _EditGardenScreenState extends State<EditGardenScreen> {
  String _name = 'Edit Garden';
  int _columns = 5;
  int _rows = 5;

  @override
  void initState() {
    super.initState();

    var gardensStore = Provider.of<GardensStore>(context, listen: false);
    Garden selectedGarden = gardensStore.gardens[gardensStore.selectedGardenIndex];
    _name = selectedGarden.name;
    _columns = selectedGarden.columns;
    _rows = selectedGarden.rows;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GardensStore>(
      builder: (context, gardensStore, child) {
        return Scaffold(
          appBar: BaseAppBar(
            backScreenID: MainScreen.id,
            title: 'Edit $_name',
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

  Future<void> _save() async {
    var gardensStore = Provider.of<GardensStore>(context, listen: false);
    gardensStore.updateSelectedGarden(name: _name, rows: _rows, columns: _columns);
    await gardensStore.saveGardens();
    Navigator.pushReplacementNamed(context, MainScreen.id);
  }
}
