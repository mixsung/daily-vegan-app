import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime(2021),
          lastDay: DateTime(2040),
          onFormatChanged: (CalendarFormat _format) {
            setState(() {
              format = _format;
            });
          },
        ),
      ),
    );
  }
}
