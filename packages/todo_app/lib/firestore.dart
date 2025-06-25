import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference notes = FirebaseFirestore.instance.collection('tasks');

  Future<void> addNote(String note, bool isChecked){
    return notes.add({
      'task': note,
      'isChecked': isChecked,
      'timestamp': Timestamp.now()
    });
  }

  Stream<QuerySnapshot> getNotesStream(){
    final notesStream = notes.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }
}