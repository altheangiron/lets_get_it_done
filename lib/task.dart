/* CUBIT - this class creates the task object:
    + saves state between Presentation Layer (UI) and Business Logic Layer */

class Task {
  final String title;
  bool value;

  Task({required this.title, this.value = false});

  @override
  String toString() => title;
}