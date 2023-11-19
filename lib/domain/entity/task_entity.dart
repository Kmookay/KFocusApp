class TaskEntity {
  late int id;
  final String name;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  TaskEntity(
      {required this.name,
      required this.description,
      required this.dueDate,
      required this.isCompleted});
}
