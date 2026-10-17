import 'package:get/get.dart';

import '../database/local_storage.dart';
import '../database/tasks_database.dart';
import '../models/task_model.dart';

class HomeController extends GetxController {
  final _db = TasksDatabase();
  final _storage = LocalStorage();

  final userName = ''.obs;
  final tasks = <TaskModel>[].obs;
  final isLoading = true.obs;
  final error = RxnString();

  int get doneCount => tasks.where((t) => t.isDone).length;
  int get todoCount => tasks.length - doneCount;

  @override
  void onInit() {
    super.onInit();
    _storage.getUserName().then((n) => userName.value = n ?? '');

    // Live updates from Firestore
    tasks.bindStream(
      _db.watchTasks().map((list) {
        isLoading.value = false;
        error.value = null;
        return list;
      }).handleError((e) {
        isLoading.value = false;
        error.value = e.toString();
      }),
    );
  }

  Future<void> deleteTask(String id) => _db.deleteTask(id);
}
