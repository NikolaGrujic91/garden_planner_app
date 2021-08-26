import 'package:flutter/material.dart';

import '../widgets/styled_text.dart';

class DatePicker extends StatefulWidget {
  final String restorationId;
  final Function callback;
  late final int day;
  late final int month;
  late final int year;

  DatePicker({required this.restorationId, required this.callback, required String initialDate}) {
    if (initialDate.isEmpty) {
      var now = DateTime.now();
      year = now.year;
      month = now.month;
      day = now.day;
    } else {
      var dateParts = initialDate.split(".");
      day = int.parse(dateParts[0]);
      month = int.parse(dateParts[1]);
      year = int.parse(dateParts[2]);
    }
  }

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> with RestorationMixin {
  late RestorableDateTime _selectedDate;

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture = RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @override
  void initState() {
    super.initState();
    _selectedDate = RestorableDateTime(DateTime(widget.year, widget.month, widget.day));
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        _restorableDatePickerRouteFuture.present();
      },
      child: const StyledText(text: 'Change planted date'),
    );
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(_restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  static Route<DateTime> _datePickerRoute(BuildContext context, Object? arguments) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2000, 1, 1),
          lastDate: DateTime(2100, 1, 1),
        );
      },
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: StyledText(text: 'Selected: ${_selectedDate.value.day}.${_selectedDate.value.month}.${_selectedDate.value.year}'),
          ),
        );
        widget.callback('${_selectedDate.value.day}.${_selectedDate.value.month}.${_selectedDate.value.year}');
      });
    }
  }
}
