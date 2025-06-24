import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/task_tile.dart';
import 'package:todo_app/task_storage.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_app/todo_info_dialog.dart';
import 'package:go_router/go_router.dart';


class Home extends HookWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    final TaskStorage _storage = TaskStorage();
    final tasks = useState<TodoList>(const TodoList([
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

  void showPage()async{
    final taskTitle = await context.push('/add-task');
    if (taskTitle is String) {
      tasks.value = tasks.value.copyWith(
            tasks: [...tasks.value.tasks, Task(title: taskTitle, isChecked: false)]
          );
          _saveTasks();
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
                builder: (context) => TodoInfoDialog(todoList: tasks.value),
              );
            },
          )
        ],
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
        onPressed: showPage,
        child: const Icon(Icons.add)),
      );
  }
}