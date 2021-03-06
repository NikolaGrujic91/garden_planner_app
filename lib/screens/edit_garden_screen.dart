// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/widgets/garden_editor.dart';
import 'package:provider/provider.dart';

/// Edit Garden Screen Widget
class EditGardenScreen extends StatelessWidget {
  /// Creates a new instance
  const EditGardenScreen({super.key});

  /// Screen ID
  static const String id = 'edit_garden_screen';

  @override
  Widget build(BuildContext context) {
    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    final selectedGarden = gardensStore.getSelectedGarden();

    return GardenEditor.edit(
      selectedGarden.name,
      selectedGarden.columns,
      selectedGarden.rows,
    );
  }
}
