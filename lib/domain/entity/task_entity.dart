class TaskEntity {
  late int id;
  final String title;
  String? note;
  final int pomodoroCount;
  DateTime? startTime;
  DateTime? dueTime;
  final bool isCompleted;
  int completedPomodoroCount = 0;

  TaskEntity(
      {required this.title,
      required this.pomodoroCount,
      required this.isCompleted,
      this.startTime,
      this.dueTime,
      this.note});
}
