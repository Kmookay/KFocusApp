import 'package:flutter/material.dart';
import 'package:k_focus/app/ui/pages/home/home_page.dart';
import 'package:k_focus/app/ui/pages/setting/setting_page.dart';
import 'package:k_focus/app/ui/pages/task/task_list_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const routeName = "/";

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  int _currentTabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.task), label: "Task"),
            NavigationDestination(icon: Icon(Icons.home), label: "KFocus"),
            NavigationDestination(icon: Icon(Icons.settings), label: "Settings")
          ],
          selectedIndex: _currentTabIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentTabIndex = index;
            });
          },
        ),
        body: const <Widget>[
          TaskListPage(),
          HomePage(),
          SettingPage()
        ][_currentTabIndex]);
  }
}
