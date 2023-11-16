import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  static const routeName = "setting";

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
          title: const Text("Setting"),
        )
      ],
    )));
  }
}
