import 'package:flutter/material.dart';
import 'package:k_focus/app/ui/pages/home/home_page.dart';

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
      home: const HomePage(),
    );
  }
}
