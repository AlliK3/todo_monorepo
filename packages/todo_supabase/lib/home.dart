

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_ui/task.dart';
import 'package:todo_ui/task_tile.dart';
import 'package:todo_ui/todo.dart';
import 'package:todo_ui/todo_info_dialog.dart';

class Home extends HookWidget {
  Home({super.key});



  @override
  Widget build(BuildContext context) {
    const tasks = TodoList([
      Task(title: 'Phase 1', isChecked: false),
      Task(title: 'HW', isChecked: false),
      Task(title: 'HW2',isChecked:  true),
    ]);

   
  void showPage() async{
    final taskTitle = await context.push('/add-task');
    if (taskTitle is String) {
      await Supabase.instance.client.from('todos').insert({
        'title': taskTitle,
        'is_completed': false
      });
    }
  }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spartans Todo List"),
        backgroundColor: Colors.green[700],
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'List Info',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const TodoInfoPage(todoList: tasks),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Supabase.instance.client.from('todos').stream(primaryKey: ['id']),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index){
              final task_data = tasks[index];
              final task = Task(title: task_data['title'], isChecked: task_data['is_completed']);
              return TaskTile(
                task: task,
                 onDelete: (){},
                  onToggle: (){});
            }
          );
        }),
        floatingActionButton: FloatingActionButton(
        onPressed: showPage,
        child: const Icon(Icons.add)),
      );
  }
}