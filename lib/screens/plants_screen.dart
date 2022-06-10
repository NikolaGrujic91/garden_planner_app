// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/screens/tiles_screen.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/plants_list.dart';

/// Plants Screen Widget
class PlantsScreen extends StatelessWidget {
  /// Creates a new instance
  const PlantsScreen({super.key});

  /// Screen ID
  static const String id = 'plants_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        backScreenID: TilesScreen.id,
        title: 'Plants',
      ),
      body: PlantsList(),
    );
  }
}
