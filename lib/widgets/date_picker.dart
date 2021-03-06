// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/string_constants.dart';
import 'package:garden_planner_app/widgets/styled_outlined_button.dart';

/// Date picker widget
class DatePicker extends StatefulWidget {
  /// Creates a new instance
  DatePicker({
    super.key,
    required this.callback,
    required this.text,
    required String initialDate,
  }) {
    if (initialDate.isEmpty) {
      final now = DateTime.now();
      year = now.year;
      month = now.month;
      day = now.day;
    } else {
      final dateParts = initialDate.split('.');
      day = int.parse(dateParts[0]);
      month = int.parse(dateParts[1]);
      year = int.parse(dateParts[2]);
    }
  }

  /// Callback function
  final Function(String plantedDate) callback;

  /// Initial day
  late final int day;

  /// Initial month
  late final int month;

  /// Initial year
  late final int year;

  /// The text to display.
  final String text;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return StyledOutlinedButton(
      text: widget.text,
      onPressed: () async {
        return Platform.isIOS || Platform.isMacOS
            ? await _showCupertinoDatePicker()
            : await _showMaterialDatePicker();
      },
    );
  }

  Future<void> _showMaterialDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(widget.year, widget.month, widget.day),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: 'Select date',
      cancelText: 'Not now',
      confirmText: kSave,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kAppBarBackgroundColor,
              surface: kBackgroundColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final date = '${picked.day}.${picked.month}.${picked.year}';
      widget.callback(date);
    }
  }

  Future<void> _showCupertinoDatePicker() async {
    DateTime? selectedDate;

    return showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 500,
        color: kBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                dateOrder: DatePickerDateOrder.dmy,
                initialDateTime: DateTime.now(),
                backgroundColor: kBackgroundColor,
                onDateTimeChanged: (val) {
                  selectedDate = val;
                },
              ),
            ),
            CupertinoButton(
              child: const Text(kSave),
              onPressed: () {
                selectedDate ??= DateTime.now();
                final date = '${selectedDate?.day}.${selectedDate?.month}'
                    '.${selectedDate?.year}';
                widget.callback(date);

                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
