import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firestore.dart';
import 'package:todo_ui/task.dart';
import 'package:todo_ui/todo.dart';
import 'package:todo_ui/task_tile.dart';
import 'package:todo_ui/task_storage.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_ui/todo_info_dialog.dart';
import 'package:go_router/go_router.dart';


class Home extends HookWidget {
  Home({super.key});

  final FirestoreService firesoreService = FirestoreService();


  @override
  Widget build(BuildContext context) {
    final tasks = useState<TodoList>(const TodoList([
      Task(title: 'Phase 1', isChecked: false),
      Task(title: 'HW', isChecked: false),
      Task(title: 'HW2',isChecked:  false),
    ]));

   
  void showPage() async{
    final taskTitle = await context.push('/add-task');
    if (taskTitle is String) {
      firesoreService.addTask(taskTitle, false);
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
                builder: (context) => TodoInfoPage(todoList: tasks.value),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firesoreService.getTasksStream(),
        builder: (context, snapshot) {
          List tasksList = snapshot.data!.docs;
          // if snapshot has data
          if(tasksList.isNotEmpty){
            return ListView.builder(
              itemCount: tasksList.length,
              itemBuilder: (context, index){
                // get each doc
                DocumentSnapshot document = tasksList[index];
                String docID = document.id;

                // get task from each doc
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String taskTitle = data['title'];
                bool taskStatus = data['isChecked'];

                // disply as list tile
                return TaskTile(
                  task: Task(title: taskTitle, isChecked: taskStatus),
                  onDelete: (){firesoreService.deleteTask(docID);},
                  onToggle: (){firesoreService.updateTask(docID, newStatus: !taskStatus);},
                );
              }
            );
          }
          else{
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No tasks yet!\nTap + to add one.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                ],
              ),
            );
          }
        },
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: showPage,
        child: const Icon(Icons.add)),
      );
  }
}