import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lets_get_it_done/task.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime today = DateTime.now();

  /* stores the tasks under respective date
  Map<DateTime, List<Task>> events = {};
  final TextEditingController _taskController = TextEditingController();*/

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('let\'s get it done',
            style: TextStyle(
              color: Color(0xffcebb9c),
            ),
          )
        ),
      ),

      /*button action
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return const AlertDialog(
              scrollable: true,
              title: Text("event name"),
              content: Padding(
                padding: EdgeInsets.all(8),
                //child: TextField(),
              )
            );
          });
        },
        child: const Icon(Icons.add),
      ),*/


      body: Column (
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xffa79558),
                  width: 2,
                )
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.black,
              ),
              todayDecoration: const BoxDecoration(
                color: Color(0xffcfc08d),
                shape: BoxShape.circle,
              ),
            ),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            focusedDay: today,
            firstDay: DateTime.utc(2024, 3, 14),
            lastDay: DateTime.utc(2025, 3, 14),
            onDaySelected: _onDaySelected,
            calendarFormat: CalendarFormat.week,
          ),
        ]
      ),
    );
  }
}