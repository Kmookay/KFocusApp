import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  var _taskList = <TaskEntity>[];

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
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Task $index"),
                  subtitle: Text("Description $index"),
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
