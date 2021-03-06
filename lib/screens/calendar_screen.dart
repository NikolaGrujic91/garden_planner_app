// Copyright 2022 Nikola Grujic. All rights reserved.
// Use of this source code is governed by a GNU-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/model/garden.dart';
import 'package:garden_planner_app/screens/tiles_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/icon_constants.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

/// Calendar Screen Widget
class CalendarScreen extends StatefulWidget {
  /// Creates a new instance
  const CalendarScreen({super.key});

  /// Screen ID
  static const String id = 'calendar_screen';

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<_IconDataStringPair>> _selectedEvents;
  late final Garden _selectedGarden;
  late final CalendarStyle _calendarStyle;

  @override
  void initState() {
    super.initState();

    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    _selectedGarden = gardensStore.getSelectedGarden();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    _calendarStyle = const CalendarStyle(
      todayDecoration: BoxDecoration(
        color: kRedColor,
        shape: BoxShape.circle,
      ),
      selectedDecoration: BoxDecoration(
        color: kRedColor,
        gradient: kRedColorGradient,
        shape: BoxShape.circle,
      ),
      markersAutoAligned: false,
      markersMaxCount: 1,
      markerDecoration: BoxDecoration(
        color: kMarkerColor,
        shape: BoxShape.circle,
      ),
      markersOffset: PositionedOffset(
        bottom: 0,
      ),
      markerSize: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backScreenID: TilesScreen.id,
        title: 'Calendar of ${_selectedGarden.name}',
      ),
      body: ColoredBox(
        color: kBackgroundColor,
        child: Column(
          children: [
            TableCalendar<dynamic>(
              focusedDay: _focusedDay,
              firstDay: DateTime(2021),
              lastDay: DateTime(2100),
              calendarFormat: _calendarFormat,
              calendarStyle: _calendarStyle,
              eventLoader: _getEventsForDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });

                  _selectedEvents.value = _getEventsForDay(selectedDay);
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 8),
            const Divider(),
            Expanded(
              child: ValueListenableBuilder<List<_IconDataStringPair>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: Icon(value[index].iconData),
                          title: Text(
                            value[index].text,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_IconDataStringPair> _getEventsForDay(DateTime date) {
    final dateKey = DateTime(date.year, date.month, date.day);

    final events = <_IconDataStringPair>[];

    for (final tile in _selectedGarden.tiles) {
      for (final plant in tile.plants) {
        if (plant.wateringDates.containsKey(dateKey)) {
          events.add(
            _IconDataStringPair.water(
              plant.wateringDates[dateKey]!,
            ),
          );
        }

        if (plant.fertilizingDates.containsKey(dateKey)) {
          events.add(
            _IconDataStringPair.fertilize(
              plant.fertilizingDates[dateKey]!,
            ),
          );
        }

        if (plant.pesticideDates.containsKey(dateKey)) {
          events.add(
            _IconDataStringPair.pesticide(
              plant.pesticideDates[dateKey]!,
            ),
          );
        }
      }
    }

    return events;
  }
}

/// Private helper class for storing icon data and string
class _IconDataStringPair {
  /// Creates a new instance
  _IconDataStringPair({
    required this.iconData,
    required this.text,
  });

  factory _IconDataStringPair.water(String text) => _IconDataStringPair(
        iconData: kWater,
        text: text,
      );

  factory _IconDataStringPair.fertilize(String text) => _IconDataStringPair(
        iconData: kFertilize,
        text: text,
      );

  factory _IconDataStringPair.pesticide(String text) => _IconDataStringPair(
        iconData: kAnt,
        text: text,
      );

  /// Icon data
  IconData iconData;

  /// String text
  String text;
}
