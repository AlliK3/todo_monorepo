import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_supabase/home.dart';
import 'package:todo_ui/task_dialog.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Home(),
        ),
        GoRoute(
          path: '/add-task',
          builder: (context, state) => AddTaskPage(), 
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
