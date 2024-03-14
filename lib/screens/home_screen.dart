import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lets_get_it_done/task.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Map<DateTime, List<Task>> selectedTasks;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    selectedTasks = {};
    super.initState();
  }

  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  List<Task> _getTasksfromDay(DateTime date) {
    return selectedTasks[date] ?? [];
  }

  void _onDaySelected(DateTime selectDay, DateTime focusDay) {
      setState(() {
       selectedDay = selectDay;
       focusedDay = focusDay;
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
      body: Column (
        children: [
          TableCalendar (
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
            selectedDayPredicate: (DateTime date) => isSameDay(selectedDay, date),
            focusedDay: selectedDay,
            firstDay: DateTime.utc(2024, 3, 14),
            lastDay: DateTime.utc(2025, 3, 14),
            onDaySelected: _onDaySelected,
            calendarFormat: CalendarFormat.week,

            eventLoader: _getTasksfromDay,

          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: const Text('To-Do:',
            style: TextStyle(
              color: Color(0xffcebb9c),
              fontSize: 20,
              )
            ),
          ),
          ..._getTasksfromDay(selectedDay).map((Task task) => ListTile(title: Text(task.title),),),
        ]  
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: const Text("Add Task"),
            content: TextFormField(
              controller: _taskController,
            ),
            actions: [
              TextButton(
                child: const Text("Add"),
                onPressed: () {
                  if(_taskController.text.isEmpty) {
            
                  }
                  else {
                    if(selectedTasks[selectedDay] != null) {
                      selectedTasks[selectedDay]?.add(
                        Task(title: _taskController.text),
                      );
                    }
                    else {
                      selectedTasks[selectedDay] = [
                        Task(title: _taskController.text)
                      ];
                    }
                    
                  }
                  Navigator.pop(context);
                  _taskController.clear();
                  setState(() {});
                  return;
                }
                
              )
            ]
          )),
        child: const Icon(Icons.add),
        ),
    );
  }
}
