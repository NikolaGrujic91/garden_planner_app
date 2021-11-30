import 'package:flutter/material.dart';
import 'package:garden_planner_app/screens/gardens_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

/// Calendar Screen Widget
class CalendarScreen extends StatefulWidget {
  /// Creates a new instance
  const CalendarScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'calendar_screen';

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        backScreenID: GardensScreen.id,
        title: 'Calendar',
      ),
      body: Container(
        color: kBackgroundColor,
        child: TableCalendar<dynamic>(
          focusedDay: _focusedDay,
          firstDay: DateTime(2021),
          lastDay: DateTime(2100),
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently
            // selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              // Call `setState()` when updating calendar format
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
        ),
      ),
    );
  }
}
