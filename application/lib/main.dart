import 'package:application/src/core/injector.dart';
import 'package:application/src/screens/student_list_page.dart';
import 'package:application/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  CustomInjector.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: {
        '/': (context) => StudentsListPage(),
      },
      initialRoute: '/',
    );
  }
}
