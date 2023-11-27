import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
            title: const Text("Task List"),
            actions: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return const TaskAddModal();
                        });
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: ListView.builder(
                itemCount: _taskList.length,
                itemBuilder: (context, index) {
                  final task = _taskList[index];
                  return Dismissible(
                          key: Key(task.title),
                      onDismissed: (direction) {
                        localRepo.deleteTask(task).then((value) {
                          Fluttertoast.showToast(
                                  msg: "Task ${task.title} deleted");
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Icon(Icons.delete),
                      ),
                    child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(task.title,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.timer,
                                            size: 15,
                                          ),
                                          Text(task.pomodoroCount.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.play_arrow))
                              ],
                            ))),
                    );
                  })
            ,
          )
          ),
        ],
      )),
    ));
  }
}
