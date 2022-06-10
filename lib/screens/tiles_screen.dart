// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/screens/gardens_screen.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/tiles_bottom_bar.dart';
import 'package:garden_planner_app/widgets/tiles_grid_view.dart';
import 'package:provider/provider.dart';

/// Tiles Screen Widget
class TilesScreen extends StatelessWidget {
  /// Creates a new instance
  const TilesScreen({super.key});

  /// Screen ID
  static const String id = 'tiles_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<GardensStoreHive>(
      builder: (context, gardensStore, child) {
        return Scaffold(
          appBar: BaseAppBar(
            backScreenID: GardensScreen.id,
            title: gardensStore.getSelectedGarden().name,
            showCalendarButton: true,
          ),
          body: const TilesGrid(),
          bottomNavigationBar: const TilesBottomBar(),
        );
      },
    );
  }
}
