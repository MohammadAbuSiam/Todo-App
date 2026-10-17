import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus { todo, done }

class TaskModel {
  final String id;
  final String title;
  final TaskStatus status;
  final DateTime createdAt;

  const TaskModel({
    required this.id,
    required this.title,
    required this.status,
    required this.createdAt,
  });

  bool get isDone => status == TaskStatus.done;

  factory TaskModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    final ts = data['createdAt'];
    return TaskModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      status: data['status'] == 'done' ? TaskStatus.done : TaskStatus.todo,
      // serverTimestamp may be null for a moment on the local write
      createdAt: ts is Timestamp ? ts.toDate() : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'status': status.name,
        'createdAt': FieldValue.serverTimestamp(),
      };
}
