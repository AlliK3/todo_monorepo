import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_ui/task.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> tasks =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(String title, bool isChecked) async {
    await tasks.add({
      'title': title,
      'isChecked': isChecked,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getTasksStream(){
    final tasksStream = tasks.orderBy('timestamp', descending: true).snapshots();

    return tasksStream;
  }

  Future<void> updateTask(String docID, {String? newTitle, bool? newStatus}){
    final updatedData = <String, dynamic>{'timestamp':Timestamp.now()};

    if(newTitle != null) updatedData['title'] = newTitle;
    if(newStatus != null) updatedData['isChecked'] = newStatus;
    return tasks.doc(docID).update(updatedData);
  }

  Future<void> deleteTask(String docID){
    return tasks.doc(docID).delete();
  }
}