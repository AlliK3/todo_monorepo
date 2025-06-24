import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddTaskPage extends HookWidget {

  const AddTaskPage({super.key});

   @override
  Widget build(BuildContext context) {
  final TextEditingController _textController = TextEditingController();

  void _submit() {
    String taskTitle = _textController.text.trim();
      if (taskTitle.isNotEmpty) {
        Navigator.of(context).pop(taskTitle); // ✅ Return the task title
      }
  }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Enter new task title',
              ),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
