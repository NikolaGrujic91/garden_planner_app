// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/screens/tiles_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/string_constants.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:provider/provider.dart';

/// Edit Tile Type Screen Widget
class EditTileTypeScreen extends StatefulWidget {
  /// Creates a new instance
  const EditTileTypeScreen({super.key});

  /// Screen ID
  static const String id = 'edit_tile_type_screen';

  @override
  State<EditTileTypeScreen> createState() => _EditTileTypeScreenState();
}

class _EditTileTypeScreenState extends State<EditTileTypeScreen> {
  TileType _tileType = TileType.plant;

  @override
  void initState() {
    super.initState();

    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    final selectedTile = gardensStore.getSelectedTile();
    _tileType = selectedTile.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backScreenID: TilesScreen.id,
        title: 'Edit tile type',
        saveCallback: _save,
      ),
      body: ColoredBox(
        color: kBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Material(
                child: RadioListTile<TileType>(
                  title: const StyledText(text: kPlant),
                  value: TileType.plant,
                  groupValue: _tileType,
                  onChanged: _setTileType,
                  tileColor: kBackgroundColor,
                ),
              ),
              Material(
                child: RadioListTile<TileType>(
                  title: const StyledText(text: kHome),
                  value: TileType.home,
                  groupValue: _tileType,
                  onChanged: _setTileType,
                  tileColor: kBackgroundColor,
                ),
              ),
              Material(
                child: RadioListTile<TileType>(
                  title: const StyledText(text: kPath),
                  value: TileType.path,
                  groupValue: _tileType,
                  onChanged: _setTileType,
                  tileColor: kBackgroundColor,
                ),
              ),
              Material(
                child: RadioListTile<TileType>(
                  title: const StyledText(text: kNone),
                  value: TileType.none,
                  groupValue: _tileType,
                  onChanged: _setTileType,
                  tileColor: kBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setTileType(TileType? type) {
    setState(() {
      _tileType = type!;
    });
  }

  Future<void> _save() async {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false)
      ..updateSelectedTileType(type: _tileType);
    await gardensStore.saveGardens();

    if (!mounted) return;
    await Navigator.pushReplacementNamed(context, TilesScreen.id);
  }
}
