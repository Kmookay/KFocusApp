import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  static const routeName = "task_list";

  @override
  State<StatefulWidget> createState() {
    return _TaskListPageState();
  }
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
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
    );
  }
}
