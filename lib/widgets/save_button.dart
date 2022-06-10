// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/string_constants.dart';

/// This widget represents reusable save button
class SaveButton extends StatelessWidget {
  /// Creates a new instance
  const SaveButton({
    super.key,
    required this.callback,
  });

  /// Callback function
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callback,
      child: const Text(
        kSaveUpper,
        style: TextStyle(
          fontFamily: 'Roboto Sans',
          color: kWhiteColor,
        ),
      ),
    );
  }
}
