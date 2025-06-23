import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/task_dialog.dart';
import 'package:todo_app/task_tile.dart';
import 'package:todo_app/task_storage.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Home extends HookWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    final TaskStorage _storage = TaskStorage();
    final tasks = useState<TodoList>(TodoList([
      Task(title: 'Phase 1', isChecked: false),
      Task(title: 'HW', isChecked: false),
      Task(title: 'HW2',isChecked:  false),
    ]));

    useEffect(() {
        _storage.loadTasks().then((loadedTasks) {
          tasks.value = loadedTasks;
        });
        return null;
      }, []);

  void _saveTasks() {
    _storage.saveTasks(tasks.value);
  }

  void _showDialog(){

    showDialog(
      context: context,
      builder: (context) => TaskDialog(
        onTaskAdded: (taskTitle){
            tasks.value = tasks.value.copyWith(
              tasks: [...tasks.value.tasks, Task(title: taskTitle, isChecked: false)]
            );
            _saveTasks();
        }
      )
    );
  }

  
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spartans Todo List"),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body:  tasks.value.tasks.isEmpty
    ? Center(
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
      )
    : ListView.builder(
        itemCount: tasks.value.tasks.length,
        itemBuilder: (context, index){
          return TaskTile(
            task: tasks.value.tasks[index],
            onDelete: () {
                final updatedTasks = [...tasks.value.tasks]..removeAt(index);
        tasks.value = tasks.value.copyWith(tasks: updatedTasks);
                _saveTasks();
            },
            onToggle: () {
                final task = tasks.value.tasks[index];
                final updatedTasks = [...tasks.value.tasks];
        final toggled = task.copyWith(isChecked: !task.isChecked);
        updatedTasks[index] = toggled;
        tasks.value = tasks.value.copyWith(tasks: updatedTasks);
                tasks.value = TodoList([...tasks.value.tasks]);
                _saveTasks();
            },
          );
        }
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: const Icon(Icons.add)),
      );
  }
}