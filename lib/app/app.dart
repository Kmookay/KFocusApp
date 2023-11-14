import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:k_focus/app/routes.dart';

class KFocusApp extends StatelessWidget {
  const KFocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(routes: Routes.routes),
    );
  }
}
