import 'package:go_router/go_router.dart';
import 'package:k_focus/app/ui/pages/chart/chart_page.dart';
import 'package:k_focus/app/ui/pages/main/main_page.dart';
import 'package:k_focus/app/ui/pages/setting/setting_page.dart';
import 'package:k_focus/app/ui/pages/task/task_list_page.dart';

class Routes {
  static final routes = [
    GoRoute(
        path: MainPage.routeName,
        builder: (context, state) => const MainPage(),
        routes: [
          GoRoute(
              path: SettingPage.routeName,
              builder: (context, state) => const SettingPage()),
          GoRoute(
              path: TaskListPage.routeName,
              builder: (context, state) => const TaskListPage()),
          GoRoute(
              path: ChartPage.routeName,
              builder: (context, state) => const ChartPage()),
        ]),
  ];
}
