import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/home.dart';
import 'package:todo_ui/task_dialog.dart';

void main() async{
  
  await Supabase.initialize(
  url: 'https://wgoocxhsoudslioecgok.supabase.col',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indnb29jeGhzb3Vkc2xpb2VjZ29rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEyNzE3MTcsImV4cCI6MjA2Njg0NzcxN30.PI9D3VTh6hiVwHmpvwgIuWDpk00FxLcW5W3FvIPSoIk',
);

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
