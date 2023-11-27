import 'package:drift/drift.dart';
import 'package:k_focus/domain/entity/task_entity.dart';

import '../../db/kfocus_db.dart';

/// task local repo
///
/// @author @Kmookay
/// @since 2023-11-17 22:30
class TaskLocalRepo {
  final _db = KFocusDB();

  static final TaskLocalRepo _singleton = TaskLocalRepo._internal();

  factory TaskLocalRepo() {
    return _singleton;
  }

  TaskLocalRepo._internal();

  Future<int> insertTask(TaskEntity task) async {
    final taskCompanion = TTaskCompanion.insert(
        title: task.title,
        note: Value(task.note),
        pomodoroCount: Value(task.pomodoroCount),
        startTime: Value(task.startTime),
        dueTime: Value(task.dueTime),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isDone: Value(task.isCompleted));
    return await _db.into(_db.tTask).insert(taskCompanion);
  }

  Future<int> deleteTask(TaskEntity task) async {
    return (_db.delete(_db.tTask)..where((t) => t.id.equals(task.id))).go();
  }

  Stream<List<TaskEntity>> taskList() {
    return _db.select(_db.tTask).watch().map((event) {
      return event.map((e) {
        TaskEntity task = TaskEntity(
            title: e.title,
            note: e.note,
            pomodoroCount: 1,
            startTime: e.startTime,
            dueTime: e.dueTime,
            isCompleted: e.isDone);
        task.id = e.id;
        return task;
      }).toList();
    });
  }
}
