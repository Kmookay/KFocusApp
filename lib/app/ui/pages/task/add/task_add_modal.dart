import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:k_focus/data/repository/local/task_local_repo.dart';
import 'package:k_focus/domain/entity/task_entity.dart';

/// TaskAddModal
///
/// @author kmookay
/// @since 2023-11-16 22:00
class TaskAddModal extends StatefulWidget {
  const TaskAddModal({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TaskAddModalState();
  }
}

class _TaskAddModalState extends State<TaskAddModal> {
  final _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Center(child: Text("Add Task")),
          const SizedBox(
            height: 20,
          ),
          TextField(
            maxLines: 5,
            controller: _taskController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Enter task name"),
          ),
          const Spacer(),
          FilledButton(
              onPressed: () {
                _addTask();
              },
              child: const Text("Confirm")),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  void _addTask() {
    if (_taskController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Task name cannot be empty");
      return;
    }

    final localRepo = TaskLocalRepo();
    localRepo
        .insertTask(TaskEntity(
            name: "test",
            description: _taskController.text,
            dueDate: DateTime.now(),
            isCompleted: false))
        .then((value) {
      Fluttertoast.showToast(msg: "Task ${_taskController.text} added");
      Navigator.pop(context);
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }
}
