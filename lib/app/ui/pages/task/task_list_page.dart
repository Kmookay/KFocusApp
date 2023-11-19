import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:k_focus/data/repository/local/task_local_repo.dart';
import 'package:k_focus/domain/entity/task_entity.dart';

import 'add/task_add_modal.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  static const routeName = "task_list";

  @override
  State<StatefulWidget> createState() {
    return _TaskListPageState();
  }
}

class _TaskListPageState extends State<TaskListPage> {
  var _taskList = List<TaskEntity>.empty(growable: true);

  final localRepo = TaskLocalRepo();
  late StreamSubscription<List<TaskEntity>> _taskListSubscription;

  @override
  void initState() {
    super.initState();
    _taskListSubscription = localRepo.taskList().listen((value) {
      setState(() {
        _taskList = value;
      });
    });
  }

  @override
  void dispose() {
    _taskListSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
      child: SafeArea(
          child: Column(
        children: [
          AppBar(
            leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text("Task List"),
            actions: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const TaskAddModal();
                        });
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _taskList.length,
              itemBuilder: (context, index) {
                final task = _taskList[index];
                return ListTile(
                  title: Text("Task ${task.name}"),
                  subtitle: Text("Description ${task.description}"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                );
              },
            ),
          ),
        ],
      )),
    ));
  }
}
