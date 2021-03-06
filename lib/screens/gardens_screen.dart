// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/screens/add_garden_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/icon_constants.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/gardens_list.dart';

/// Main Screen Widget
class GardensScreen extends StatelessWidget {
  /// Creates a new instance
  const GardensScreen({super.key});

  /// Screen ID
  static const String id = 'gardens_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Grow',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushReplacementNamed(context, AddGardenScreen.id);
        },
        tooltip: 'Add garden',
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: kRedColorGradient,
          ),
          child: Icon(kAddIcon),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          GardensList(),
        ],
      ),
    );
  }
}
