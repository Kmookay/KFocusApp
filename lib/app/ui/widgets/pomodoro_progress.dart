import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PomodoroProgress extends StatefulWidget {
  int pomodoroCount = 4;

  Function? onComplete;

  PomodoroProgress({super.key, required this.pomodoroCount});

  @override
  State<StatefulWidget> createState() {
    return PomodoroProgressState();
  }
}

class PomodoroProgressState extends State<PomodoroProgress> {
  int currentPomodoro = -1;
  PomodoroItemState state = PomodoroItemState.idle;

  @override
  Widget build(BuildContext context) {
    return _progress();
  }

  Widget _progress() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(widget.pomodoroCount, (int index) {
          if (index < currentPomodoro) {
            return _item(PomodoroItemState.complete);
          } else if (index == currentPomodoro) {
            switch (state) {
              case PomodoroItemState.complete:
                return _item(PomodoroItemState.complete);
              case PomodoroItemState.running:
                return _item(PomodoroItemState.running);
              default:
                return _item(PomodoroItemState.complete);
            }
          } else {
            return _item(PomodoroItemState.idle);
          }
        }));
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

  /// reset pomodoro progress
  void reset() {
    setState(() {
      currentPomodoro = -1;
      state = PomodoroItemState.idle;
    });
  }

  /// start next pomodoro
  void start() {
    assert(currentPomodoro < widget.pomodoroCount,
        'pomodoro count should less than ${widget.pomodoroCount}');
    assert(state != PomodoroItemState.running, "pomodoro is running");
    setState(() {
      currentPomodoro++;
      state = PomodoroItemState.running;
    });
  }

  /// abort current pomodoro
  void abort() {
    setState(() {
      currentPomodoro--;
      state = PomodoroItemState.idle;
    });
  }

  /// the one pomodoro has count down done
  void complete() {
    assert(state == PomodoroItemState.running, "pomodoro is not running");
    setState(() {
      state = PomodoroItemState.complete;
    });
  }
}

enum PomodoroItemState { idle, running, complete }
