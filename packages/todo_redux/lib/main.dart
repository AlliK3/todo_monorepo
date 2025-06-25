import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_redux/app_state.dart';
import 'package:todo_redux/home.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_redux/reducer.dart';
import 'package:todo_ui/task.dart';
import 'package:todo_ui/task_dialog.dart';
import 'package:redux/redux.dart';


void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Store<AppState> _store = Store<AppState>(
    appReducer,
    initialState: AppState(tasks: [
      const Task(title: 'HW1', isChecked: false),
      const Task(title: 'HW2', isChecked: true)
    ])
  );

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Home(),
        ),
        GoRoute(
          path: '/add-task',
          builder: (context, state) => const AddTaskPage(), 
        ),
      ],
    );

    return StoreProvider(
      store: _store,
      child: MaterialApp.router(
        routerConfig: _router,
      ),
    );
  }
}
