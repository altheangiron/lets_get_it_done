class Task {
  String title;
  bool value;
  int? borderColorValue;

  Task({required this.title, this.value = false, this.borderColorValue = 0});

  @override
  String toString() => title;
}