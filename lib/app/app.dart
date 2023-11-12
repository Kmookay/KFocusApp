import 'package:flutter/material.dart';

class KFocusApp extends StatelessWidget {
  const KFocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
      ),
      home: const KFocusHomePage(),
    );
  }
}

class KFocusHomePage extends StatefulWidget {
  const KFocusHomePage({super.key});

  @override
  State<KFocusHomePage> createState() => _KFocusHomePageState();
}

class _KFocusHomePageState extends State<KFocusHomePage> {
  var time = "25:00";
  var seconds = 25 * 60;
  var state = FocusState.idle;
  var operationText = "Start";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
        child: Container(
      color: Colors.white,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.data_object),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.settings)
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                time,
                style: const TextStyle(fontSize: 48, color: Colors.black),
              ),
            ),
          ),
          TextButton(onPressed: _operationClick, child: Text(operationText)),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }

  void _operationClick() {
    switch (state) {
      case FocusState.idle:
        _startCountDown();
        break;
      case FocusState.running:
        _pauseCountDown();
        break;
      case FocusState.paused:
        _resumeCountDown();
        break;
      default:
    }
  }

  void _startCountDown() {
    setState(() {
      operationText = "Pause";
      state = FocusState.running;
    });
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        seconds--;
        _formatTime();
      });
      return seconds > 0 && state != FocusState.paused;
    }).then((value) {
      setState(() {
        operationText = "Start";
        state = FocusState.idle;
      });
    });
  }

  void _pauseCountDown() {
    setState(() {
      operationText = "Resume";
      state = FocusState.paused;
    });
  }

  void _resumeCountDown() {
    setState(() {
      operationText = "Pause";
      state = FocusState.running;
    });
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        seconds--;
        _formatTime();
      });
      return seconds > 0 && state != FocusState.paused;
    }).then((value) {
      setState(() {
        operationText = "Start";
        state = FocusState.idle;
      });
    });
  }

  void _formatTime() {
    var minute = seconds ~/ 60;
    var second = seconds % 60;
    var minuteStr = minute < 10 ? "0$minute" : "$minute";
    var secondStr = second < 10 ? "0$second" : "$second";
    setState(() {
      time = "$minuteStr:$secondStr";
    });
  }
}

enum FocusState { idle, running, paused, finished }
