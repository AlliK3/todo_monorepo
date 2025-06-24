import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_redux/actions.dart';
import 'package:todo_redux/app_state.dart';
import 'package:todo_ui/task.dart';
import 'package:todo_ui/todo.dart';
import 'package:todo_ui/task_tile.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_ui/todo_info_dialog.dart';

class Home extends HookWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spartans Todo List"),
        backgroundColor: Colors.green[700],
        centerTitle: true,
        actions: [
          StoreConnector<AppState, List<Task>>(
            converter: (store) => store.state.tasks,
            builder: (context, tasks) {
                return IconButton(
                  icon: const Icon(Icons.info_outline),
                  tooltip: 'List Info',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => TodoInfoPage(todoList: TodoList(tasks)),
                    );
                  },
                );
            }
          )
        ],
      ),
      body: StoreConnector<AppState, List<Task>>(
        converter: (store) => store.state.tasks,
        builder: (context, tasks) {
          if (tasks.isEmpty) {
            return Center(
              child: Text(
                'No tasks yet!\nTap + to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return TaskTile(
                task: task,
                onDelete: () {
                  StoreProvider.of<AppState>(context)
                      .dispatch(DeleteTaskAction(index));
                },
                onToggle: () {
                  StoreProvider.of<AppState>(context)
                      .dispatch(ToggleTaskAction(index));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final taskTitle = await context.push('/add-task');
          if (taskTitle is String) {
            final newTask = Task(title: taskTitle, isChecked: false);
            StoreProvider.of<AppState>(context).dispatch(AddTaskAction(newTask));
          }
        },
        child: const Icon(Icons.add),
      )
    );
  }
}