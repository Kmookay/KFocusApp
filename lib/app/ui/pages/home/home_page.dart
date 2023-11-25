import 'dart:async';

import 'package:flutter/material.dart';
import 'package:k_focus/app/ui/widgets/pomodoro_progress.dart';
import 'package:k_focus/domain/entity/task_entity.dart';
import 'package:k_focus/utils/int_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final pomodoroTime = 1 * 60;
  var _time = "";
  double _taskProgress = 0;
  Timer? _timer;
  PomodoroState _pomodoroState = PomodoroState.idle;
  TaskEntity? _currentTask = TaskEntity(
      name: "test",
      description: "Today task",
      pomodoroCount: 2,
      dueDate: DateTime.now(),
      isCompleted: false);

  final GlobalKey<PomodoroProgressState> pomodoroProgressKey =
      GlobalKey<PomodoroProgressState>();

  _HomePageState() {
    _time = _formatTimeShow(pomodoroTime);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
        child: SafeArea(
            child: Stack(
      children: [
        Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => {
                                  // todo: show today task list
                                },
                            icon: const Icon(Icons.format_list_bulleted)),
                        IconButton(
                            onPressed: () => _reset(),
                            icon: const Icon(Icons.restore))
                      ],
                    )),
                Expanded(
                    child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _time,
                        style: const TextStyle(
                            fontSize: 48,
                            fontFamily: "Courier",
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PomodoroProgress(
                          key: pomodoroProgressKey, pomodoroCount: 4),
                      const SizedBox(
                        height: 30,
                      ),
                      _operationByState(),
                    ],
                  ),
                )),
                const SizedBox(
                  height: 20,
                )
              ],
            )),
        _task()
      ],
    )));
  }

  Widget _task() {
    if (_currentTask == null) {
      return Container();
    }
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(100, 80, 100, 0),
      child: Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _currentTask!.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 240,
                    child: Center(
                      child: LinearProgressIndicator(
                        value: _taskProgress,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ))),
    );
  }

  Widget _operationByState() {
    switch (_pomodoroState) {
      case PomodoroState.complete:
        return _operationStateComplete();
      case PomodoroState.running:
        return _operationStateRunning();
      default:
        return _operationStateIdle();
    }
  }

  Widget _operationStateIdle() {
    return FilledButton(
        onPressed: () {
          _start();
        },
        child: const Text("Start"));
  }

  Widget _operationStateRunning() {
    return FilledButton(
        onPressed: () {
          _abort();
        },
        child: const Text("Abort"));
  }

  Widget _operationStateComplete() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FilledButton(
            onPressed: () {
              _start();
            },
            child: const Text("Start")),
        const SizedBox(width: 20),
        FilledButton(
            onPressed: () {
              _complete();
            },
            child: const Text("Complete"))
      ],
    );
  }

  /// Reset the timer
  void _reset() {
    _abort();
    pomodoroProgressKey.currentState?.reset();
  }

  /// Start the timer
  void _start() {
    _timer?.cancel();
    setState(() {
      _pomodoroState = PomodoroState.running;
    });
    pomodoroProgressKey.currentState?.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int releaseTime = pomodoroTime - timer.tick;
      setState(() {
        if (releaseTime == 0) {
          _timer?.cancel();
          _pomodoroState = PomodoroState.complete;
          releaseTime = pomodoroTime;
          pomodoroProgressKey.currentState?.complete();
        }
        _time = _formatTimeShow(releaseTime);
        _taskProgress = _calTaskProgress(timer.tick);
      });
    });
  }

  /// Abort the timer
  void _abort() {
    _timer?.cancel();
    pomodoroProgressKey.currentState?.abort();
    setState(() {
      _pomodoroState = PomodoroState.idle;
      _time = _formatTimeShow(pomodoroTime);
      _taskProgress = _calTaskProgress(0);
    });
  }

  String _formatTimeShow(int time) {
    return "${(time ~/ 60).padZero()}:${(time % 60).padZero()}";
  }

  void _complete() {
    // todo: mark this task as complete, and start next task
  }

  double _calTaskProgress(int currentPomodoroTime) {
    if (_currentTask == null) {
      return 0;
    }
    return (_currentTask!.completedPomodoroCount * pomodoroTime +
                currentPomodoroTime)
            .toDouble() /
        (_currentTask!.pomodoroCount * pomodoroTime).toDouble();
  }

  @override
  bool get wantKeepAlive => true;
}

enum PomodoroState {
  /// The timer is idle
  idle,

  /// The timer is running
  running,

  /// The timer is complete
  complete
}
