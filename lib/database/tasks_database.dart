import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_model.dart';

/// All Firestore operations for tasks live here.
/// Each user's tasks are stored under: users/{uid}/tasks
class TasksDatabase {
  CollectionReference<Map<String, dynamic>> get _collection {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw StateError('User is not signed in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks');
  }

  Stream<List<TaskModel>> watchTasks() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(TaskModel.fromDoc).toList());
  }

  Future<void> addTask(String title) {
    return _collection.add({
      'title': title.trim(),
      'status': TaskStatus.todo.name,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTask(String id, {String? title, TaskStatus? status}) {
    return _collection.doc(id).update({
      if (title != null) 'title': title.trim(),
      if (status != null) 'status': status.name,
    });
  }

  Future<void> deleteTask(String id) => _collection.doc(id).delete();
}
