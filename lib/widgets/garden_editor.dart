import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/model/garden.dart';
import 'package:garden_planner_app/screens/gardens_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/string_constants.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/preview_grid_view.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:garden_planner_app/widgets/text_field_bordered.dart';
import 'package:garden_planner_app/widgets/text_field_bordered_numeric.dart';
import 'package:provider/provider.dart';

/// Garden Editor Widget
class GardenEditor extends StatefulWidget {
  /// Creates a new instance
  const GardenEditor({
    Key? key,
    required this.name,
    required this.columns,
    required this.rows,
    required this.title,
    required this.isEditMode,
  }) : super(key: key);

  /// Creates a new instance for adding new garden
  factory GardenEditor.add(String name, int columns, int rows) => GardenEditor(
        name: name,
        columns: columns,
        rows: rows,
        title: 'Add $name',
        isEditMode: false,
      );

  /// Creates a new instance for editing existing garden
  factory GardenEditor.edit(String name, int columns, int rows) => GardenEditor(
        name: name,
        columns: columns,
        rows: rows,
        title: 'Edit $name',
        isEditMode: true,
      );

  /// Name of the garden
  final String name;

  /// Number of columns in preview grid
  final int columns;

  /// Number of rows in preview grid
  final int rows;

  /// Title in the app bar
  final String title;

  /// Edit mode indicator
  /// true if in edit mode, false otherwise
  final bool isEditMode;

  @override
  State<GardenEditor> createState() => _GardenEditorState();
}

class _GardenEditorState extends State<GardenEditor> {
  final _verticalSpace = const SizedBox(
    height: 20,
  );
  final _horizontalSpace = const SizedBox(
    width: 20,
  );

  late String _name;
  late int _columns;
  late int _rows;

  @override
  void initState() {
    super.initState();

    _name = widget.name;
    _columns = widget.columns;
    _rows = widget.rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backScreenID: GardensScreen.id,
        title: widget.title,
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
              _verticalSpace,
              Row(
                children: [
                  TextFieldBorderedNumeric(
                    text: _rows.toString(),
                    hintText: kRows,
                    callback: _setRows,
                  ),
                  _horizontalSpace,
                  const StyledText(
                    text: 'X',
                  ),
                  _horizontalSpace,
                  TextFieldBorderedNumeric(
                    text: _columns.toString(),
                    hintText: kColumns,
                    callback: _setColumns,
                  ),
                ],
              ),
              _verticalSpace,
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
    widget.isEditMode ? await _update() : await _add();

    if (!mounted) return;
    await Navigator.pushReplacementNamed(context, GardensScreen.id);
  }

  Future<void> _update() async {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false)
      ..updateSelectedGarden(
        name: _name,
        rows: _rows,
        columns: _columns,
      );

    await gardensStore.saveGardens();
  }

  Future<void> _add() async {
    final garden = Garden(
      name: _name,
      rows: _rows,
      columns: _columns,
    );
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false)
      ..addGarden(garden);

    await gardensStore.saveGardens();
  }
}
