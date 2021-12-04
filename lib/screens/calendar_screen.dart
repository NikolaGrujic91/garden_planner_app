import 'package:flutter/material.dart';
import 'package:garden_planner_app/db/gardens_store_hive.dart';
import 'package:garden_planner_app/model/garden.dart';
import 'package:garden_planner_app/screens/tiles_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:provider/provider.dart';
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
  late final ValueNotifier<List<String>> _selectedEvents;
  late final Garden _selectedGarden;

  @override
  void initState() {
    super.initState();

    final gardensStore = Provider.of<GardensStoreHive>(context, listen: false);
    _selectedGarden = gardensStore.getSelectedGarden();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backScreenID: TilesScreen.id,
        title: 'Calendar of ${_selectedGarden.name}',
      ),
      body: Container(
        color: kBackgroundColor,
        child: Column(
          children: [
            TableCalendar<dynamic>(
              focusedDay: _focusedDay,
              firstDay: DateTime(2021),
              lastDay: DateTime(2100),
              calendarFormat: _calendarFormat,
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
            Expanded(
              child: ValueListenableBuilder<List<String>>(
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
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(value[index]),
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

  List<String> _getEventsForDay(DateTime date) {
    final dateKey = DateTime(date.year, date.month, date.day);

    final events = <String>[];

    for (final tile in _selectedGarden.tiles) {
      for (final plant in tile.plants) {
        if (plant.wateringDates.containsKey(dateKey)) {
          events.add(plant.wateringDates[dateKey]!);
        }

        if (plant.fertilizingDates.containsKey(dateKey)) {
          events.add(plant.fertilizingDates[dateKey]!);
        }
      }
    }

    return events;
  }
}
