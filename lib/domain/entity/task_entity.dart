class TaskEntity {
  late int id;
  final String name;
  final String description;
  final int pomodoroCount;
  final DateTime dueDate;
  final bool isCompleted;
  int completedPomodoroCount = 0;

  TaskEntity(
      {required this.name,
      required this.description,
      required this.pomodoroCount,
      required this.dueDate,
      required this.isCompleted});
}
