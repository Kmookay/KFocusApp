import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:k_focus/app/routes.dart';
import 'package:k_focus/app/ui/pages/home/home_page.dart';

class KFocusApp extends StatelessWidget {
  const KFocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true),
      routerConfig:
          GoRouter(initialLocation: HomePage.routeName, routes: Routes.routes),
    );
  }
}
