import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PomodoroProgress extends StatefulWidget {
  int pomodoroCount = 4;

  PomodoroProgress({required this.pomodoroCount});

  @override
  State<StatefulWidget> createState() {
    return _PomodoroProgressState();
  }
}

class _PomodoroProgressState extends State<PomodoroProgress> {
  @override
  Widget build(BuildContext context) {
    return _progress();
  }

  Widget _progress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _item(PomodoroItemState.complete),
        const SizedBox(width: 10),
        _item(PomodoroItemState.running),
        const SizedBox(width: 10),
        _item(PomodoroItemState.idle),
        const SizedBox(width: 10),
        _item(PomodoroItemState.idle),
      ],
    );
  }

  Widget _item(PomodoroItemState state) {
    switch (state) {
      case PomodoroItemState.running:
        return SvgPicture.asset(
            'public/images/pomodoro_progress_item_state_running.svg');
      case PomodoroItemState.complete:
        return SvgPicture.asset(
            'public/images/pomodoro_progress_item_state_complete.svg');
      default:
        return SvgPicture.asset(
            'public/images/pomodoro_progress_item_state_idle.svg');
    }
  }
}

enum PomodoroItemState { idle, running, complete }
