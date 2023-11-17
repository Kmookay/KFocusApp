import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:k_focus/app/ui/pages/chart/chart_page.dart';
import 'package:k_focus/app/ui/pages/setting/setting_page.dart';
import 'package:k_focus/app/ui/pages/task/task_list_page.dart';
import 'package:k_focus/utils/int_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pomodoroTime = 25 * 60;
  var _time = "";
  Timer? _timer;
  PomodoroState _pomodoroState = PomodoroState.idle;

  _HomePageState() {
    _time = _formatTimeShow(pomodoroTime);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                              onPressed: () =>
                                  context.go("/${TaskListPage.routeName}"),
                              icon: const Icon(Icons.format_list_bulleted)),
                          Row(
                        children: [
                              IconButton(
                                  onPressed: () =>
                                      context.go("/${ChartPage.routeName}"),
                                  icon: const Icon(Icons.bar_chart)),
                              IconButton(
                                  onPressed: () =>
                                      context.go("/${SettingPage.routeName}"),
                                  icon: const Icon(Icons.settings))
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Center(
                  child: Text(
                    _time,
                        style: const TextStyle(
                            fontSize: 48,
                            fontFamily: "Courier",
                            color: Colors.black),
                  ),
                )),
                _operationByState(),
                const SizedBox(
                  height: 20,
                )
              ],
                ))));
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

  /// Start the timer
  void _start() {
    _timer?.cancel();
    setState(() {
      _pomodoroState = PomodoroState.running;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int releaseTime = pomodoroTime - timer.tick;
      setState(() {
        if (releaseTime == 0) {
          _timer?.cancel();
          _pomodoroState = PomodoroState.complete;
          releaseTime = pomodoroTime;
        }
        _time = _formatTimeShow(releaseTime);
      });
    });
  }

  /// Abort the timer
  void _abort() {
    _timer?.cancel();
    setState(() {
      _pomodoroState = PomodoroState.idle;
      _time = _formatTimeShow(pomodoroTime);
    });
  }

  String _formatTimeShow(int time) {
    return "${(time ~/ 60).padZero()}:${(time % 60).padZero()}";
  }

  void _complete() {
    // todo: mark this task as complete, and start next task
  }
}

enum PomodoroState {
  /// The timer is idle
  idle,

  /// The timer is running
  running,

  /// The timer is complete
  complete
}
