import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text('Selected Day: ${today.toString().split(' ')[0]}'),
          TableCalendar(
            locale: 'en_US',
            rowHeight: 60,
            calendarStyle: CalendarStyle(
              selectedTextStyle:
                  TextStyle(color: Theme.of(context).iconTheme.color),
              todayTextStyle:
                  TextStyle(color: Theme.of(context).iconTheme.color),
              outsideDaysVisible: false,
              weekendTextStyle:
                  TextStyle(color: Theme.of(context).iconTheme.color),
              weekNumberTextStyle:
                  TextStyle(color: Theme.of(context).iconTheme.color),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            focusedDay: today,
            firstDay: DateTime.utc(2010, 01, 01),
            lastDay: DateTime.utc(2030, 31, 12),
            onDaySelected: _onDaySelected,
          ),
        ],
      ),
    );
  }
}
