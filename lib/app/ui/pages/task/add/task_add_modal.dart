import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:k_focus/app/ui/widgets/time_select_item.dart';
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
  int porodomoCount = 1;
  final _taskController = TextEditingController();
  final _pomodoroCountInputController = TextEditingController(text: '1');

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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Porodomo Count"),
              const Spacer(),
              IconButton(
                  onPressed: _removePomodoro, icon: const Icon(Icons.remove)),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 20,
                height: 20,
                child: TextField(
                  controller: _pomodoroCountInputController,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "1"),
                  cursorHeight: 20,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(onPressed: _addPomodoro, icon: const Icon(Icons.add)),
            ],
          ),
          const Divider(color: Colors.grey, height: 0.5),
          TimeSelectItem(label: "Start Date", onTimeSelected: (time) {}),
          const Divider(color: Colors.grey, height: 0.5),
          TimeSelectItem(label: "Due Date", onTimeSelected: (time) {}),
          const Divider(color: Colors.grey, height: 0.5),
          const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                  onPressed: () {
                    _addTask();
                  },
                  child: const Text("Confirm")),
            )
          ]),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  void _removePomodoro() {
    if (porodomoCount > 1) {
      setState(() {
        porodomoCount--;
        _pomodoroCountInputController.text = porodomoCount.toString();
      });
    }
  }

  void _addPomodoro() {
    setState(() {
      porodomoCount++;
      _pomodoroCountInputController.text = porodomoCount.toString();
    });
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
            pomodoroCount: 1,
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
