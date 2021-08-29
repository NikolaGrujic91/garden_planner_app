import 'package:flutter/material.dart';
import 'package:garden_planner_app/model/gardens_store.dart';
import 'package:garden_planner_app/screens/main_screen.dart';
import 'package:garden_planner_app/utils/constants.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/preview_grid_view.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:garden_planner_app/widgets/text_field_bordered.dart';
import 'package:garden_planner_app/widgets/text_field_bordered_numeric.dart';
import 'package:provider/provider.dart';

/// Edit Garden Screen Widget
class EditGardenScreen extends StatefulWidget {
  /// Creates a new instance
  const EditGardenScreen({Key? key}) : super(key: key);

  /// Screen ID
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

    final gardensStore = Provider.of<GardensStore>(context, listen: false);
    final selectedGarden =
        gardensStore.gardens[gardensStore.selectedGardenIndex];
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const StyledText(
                    text: 'Garden name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldBordered(
                    text: _name,
                    hintText: 'Name',
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
                        text: _columns.toString(),
                        hintText: 'Columns',
                        callback: _setColumns,
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
                        text: _rows.toString(),
                        hintText: 'Rows',
                        callback: _setRows,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const StyledText(
                    text: 'Preview',
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
    final gardensStore = Provider.of<GardensStore>(context, listen: false)
      ..updateSelectedGarden(name: _name, rows: _rows, columns: _columns);
    await gardensStore.saveGardens();

    if (!mounted) return;
    await Navigator.pushReplacementNamed(context, MainScreen.id);
  }
}
