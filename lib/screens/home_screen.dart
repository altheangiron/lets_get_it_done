import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lets_get_it_done/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* -- Home Screen + Add Task Page + Delete Task Page --
  This screen:
  + shows the Weekly Calendar
  + allows user to enter their task under the respective date */

/* The 'Add Task' & 'Delete Task' Pages are AlertDialog Widgets but renders a screen */

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int? borderColorValue = 0;

  dynamic taskBorder;

  Color taskBorderColor() {
    
    if(borderColorValue == 1) {
      taskBorder = const Color(0xff9ee2e6);
    }
    else if(borderColorValue == 2) {
      taskBorder = const Color(0xfff7bae7);
    }
    else if(borderColorValue == 3) {
      taskBorder = const Color(0xffcbafe3);
    }
    else {
      taskBorder = Colors.black;
    }
    return taskBorder;
  }

  void _showAddTaskDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setStateDialog) {
          return AlertDialog(
            title: const Center(
              child: Text('Add Task',
                style: TextStyle(color: Color(0xffcebb9c)),
              )
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Row(
                  children: [
                    Text('Select Type:', 
                      style: TextStyle(color: Color(0xffcebb9c)),
                    ),

                    Spacer(flex: 7),
                  ],
                ),
                RadioListTile<int>(
                  title: const Text('School', style: TextStyle(color: Color(0xff9ee2e6))),
                  value: 1,
                  groupValue: borderColorValue,
                  onChanged: (int? value) {
                    setStateDialog(() {
                      borderColorValue = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: const Text('Work', style: TextStyle(color: Color(0xfff7bae7))),
                  value: 2,
                  groupValue: borderColorValue,
                  onChanged: (int? value) {
                    setStateDialog(() {
                      borderColorValue = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: const Text('General', style: TextStyle(color: Color(0xffcbafe3))),
                  value: 3,
                  groupValue: borderColorValue,
                  onChanged: (int? value) {
                    setStateDialog(() {
                      borderColorValue = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _taskController,
                    minLines: 5,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: taskBorderColor(),
                        ),
                      ),
                      hintText: "Let's get this task done...",
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _taskController.clear();
                },
                child: const Text('Cancel', style: TextStyle(color: Color(0xffcebb9c))),
              ),
              ElevatedButton(
                onPressed: () {
                  if(_taskController.text.isEmpty) {
                    Navigator.pop(context);
                    _taskController.clear();
                  }
                  else {
                    if(selectedTasks[selectedDay] != null) {
                      selectedTasks[selectedDay]?.add(
                      Task(title: _taskController.text)
                      );
                      saveTask(_taskController.text);
                    }
                    else {
                      selectedTasks[selectedDay] = [
                        Task(title: _taskController.text)
                      ];
                    }
                                
                    Navigator.pop(context);
                    _taskController.clear();
                    setState(() {});
                    return;
                  }
                },
                child: const Text("Add", style: TextStyle(color: Color(0xffcebb9c))),
              )
            ],
          );
        }
      );
    }
  );
}

  late Map<DateTime, List<Task>> selectedTasks;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final TextEditingController _taskController = TextEditingController();

  /* shared_preferences - saves data locally */

  saveTask(String task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('task', task);
  }

  getSavedTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final taskValue = prefs.getString('task');
    return taskValue;
  }

  removeSavedTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('task');
  }

  @override
  void initState() {
    selectedTasks = {};
    getSavedTask();
    super.initState();
  }

  @override
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
      body: ListView (
        children: <Widget> [ Column (
            children: <Widget>[
          
            // TableCalendar() Widget: displays the weekly calendar
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
              child: Row(
                children: <Widget> [
                
                  const Spacer(flex: 9),
                
                  // to-do text under the calendar
                  Container(
                    margin: const EdgeInsets.only(left: 59.0),
                      child: const Center(        
                      child: Text('To-Do:',
                      style: TextStyle(
                        color: Color(0xffcebb9c),
                        fontSize: 20,
                        )
                      ),
                    ),
                  ),
                      
                  const Spacer(flex: 8),
                
                  /* '+' Button ->
                      'Add Task' Alert Dialog */
                  Container(
                    margin: const EdgeInsets.only(right: 4.0),
                    child: TextButton(
                      onPressed: _showAddTaskDialog,
                        child: const Icon(Icons.add, color: Colors.black),
                    ),
                  ),
                    
                  
                  const Spacer(),
                ],
              ),
            ),
              
            ..._getTasksfromDay(selectedDay).map((Task task) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    width: 800,
                    child: ListTile(
                      title: Text(task.title),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: taskBorderColor(),),
                        borderRadius: BorderRadius.circular(8.0),
                        ),
                      /* onTap of Task ->
                        'Edit Task' Alert Dialog */
                      onTap: () => showDialog(
                        context: context, 
                        builder: (context) => AlertDialog(
                          title: const Center(
                            child: Text('Delete Task', 
                            style: TextStyle(
                              color: Color(0xffcebb9c),
                            ),)
                          ),
                          content: SizedBox(
                            width: 50,
                            child: TextFormField(
                              minLines: 5,
                              maxLines: 5,
                              initialValue: task.title,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'let\'s get this task done..'
                              ),
                            ),
                          ),
                          actions: <Widget>[
                          
                              // allows user to cancel deleting task
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                }, 
                                child: const Text('Cancel', 
                                  style: TextStyle(
                                    color: Color(0xffcebb9c),
                                  ),
                                ),
                              ),

                              // allows user to delete task
                              ElevatedButton(
                                  onPressed: () {
                                    selectedTasks[selectedDay]?.remove(task);
                                    setState(() {});
                                    removeSavedTask();
                                    Navigator.pop(context);
                                  }, 
                                  child: const Text('Delete',
                                    style: TextStyle(
                                      color: Color(0xfff07f90),
                                    ),
                                  )
                                )
                            ]
                          ),
                        ),
                      trailing: Checkbox(
                        value: task.value, 
                        onChanged: (value) {
                          setState(() {
                            final newValue = !task.value;
                            task.value = newValue;
                          });
                        },
                        activeColor: const Color(0xffcebb9c),
                       ),
                    ),
            ),),
            
            ]
          ),
        ]
      ),
    );
  }
}
