class Task {
  String title;
  bool value;

  Task({required this.title, this.value = false});

  @override
  String toString() => title;
}