import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// ChartPage
///
/// @author kmookay
/// @since 2021-02-14 17:00
class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  static const routeName = "chart";

  @override
  State<StatefulWidget> createState() {
    return _ChartPageState();
  }
}

class _ChartPageState extends State<ChartPage> {
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
            title: const Text("Chart"),
          )
        ],
      )),
    );
  }
}
