import 'package:go_router/go_router.dart';
import 'package:k_focus/app/ui/pages/home/home_page.dart';
import 'package:k_focus/app/ui/pages/setting/setting_page.dart';

class Routes {
  static final routes = [
    GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => const HomePage()),
    GoRoute(
        path: SettingPage.routeName,
        builder: (context, state) => const SettingPage())
  ];
}
