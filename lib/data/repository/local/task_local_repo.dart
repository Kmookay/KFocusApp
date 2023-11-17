import 'package:drift/drift.dart';
import 'package:k_focus/domain/entity/task_entity.dart';

import '../../db/kfocus_db.dart';

/// task local repo
///
/// @author @Kmookay
/// @since 2023-11-17 22:30
class TaskLocalRepo {
  final _db = KFocusDB();

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

  Stream<List<TaskEntity>> taskList() async* {
    final query = _db.select(_db.tTask);
    final taskList = await query.get();
    yield taskList
        .map((task) => TaskEntity(
            name: task.title,
            description: task.description,
            dueDate: task.dueDate,
            isCompleted: task.isDone))
        .toList();
  }
}
