import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 3, now.day);
var lastDay = DateTime(now.year, now.month + 3, now.day);

class Calendario extends StatefulWidget {
  const Calendario({super.key});
  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  CalendarFormat calendarFormat = CalendarFormat.month;
  
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: now, 
          firstDay: firstDay, 
          lastDay: lastDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) => setState(() {
            this.selectedDay = selectedDay;
          }),
          onFormatChanged: (format) {
            if (calendarFormat != format) {
              setState(() {
                calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) => now = focusedDay,
          availableCalendarFormats: const {
            CalendarFormat.month: 'mês',
            CalendarFormat.week: 'semana',
            CalendarFormat.twoWeeks: '2 semanas',
          },
          headerStyle:  HeaderStyle(
            //aqui da pra estilizar bastante o calendario
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: true,
            todayDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: const Color.fromARGB(255, 76, 135, 175),
              shape: BoxShape.circle,
            ),
            markersMaxCount: 1,
          ),

        )
      ],
    );
  }
}