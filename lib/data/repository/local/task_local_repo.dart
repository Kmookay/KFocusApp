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
        title: task.name,
        description: task.description,
        dueDate: task.dueDate,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isDone: Value(task.isCompleted));
    return await _db.into(_db.tTask).insert(taskCompanion);
  }

  Stream<List<TaskEntity>> taskList() {
    return _db.select(_db.tTask).watch().map((event) {
      return event.map((e) {
        return TaskEntity(
            name: e.title,
            description: e.description,
            dueDate: e.dueDate,
            isCompleted: e.isDone);
      }).toList();
    });
  }
}
