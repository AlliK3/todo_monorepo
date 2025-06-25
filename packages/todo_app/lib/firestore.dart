import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_ui/task.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(String title, bool isChecked) async {
    await _tasksCollection.add({
      'title': title,
      'isChecked': isChecked,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<List<Task>> taskStream() {
    return _tasksCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return Task(
                id: doc.id,
                title: data['title'] ?? '',
                isChecked: data['isChecked'] ?? false,
              );
            }).toList());
  }

  /// Delete a task by its Firestore ID
  Future<void> deleteTask(String id) async {
    await _tasksCollection.doc(id).delete();
  }

  /// Toggle isChecked or update title
  Future<void> updateTask(String id, {String? title, bool? isChecked}) async {
    final updateData = <String, dynamic>{};
    if (title != null) updateData['title'] = title;
    if (isChecked != null) updateData['isChecked'] = isChecked;
    await _tasksCollection.doc(id).update(updateData);
  }
}