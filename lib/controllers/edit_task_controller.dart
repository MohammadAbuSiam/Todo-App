import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../database/tasks_database.dart';
import '../models/task_model.dart';

class EditTaskController extends GetxController {
  final _db = TasksDatabase();

  // The task is passed through Get.arguments
  final TaskModel task = Get.arguments as TaskModel;

  late final TextEditingController textController;
  late final Rx<TaskStatus> status;
  final saving = false.obs;

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController(text: task.title);
    status = task.status.obs;
  }

  Future<void> save() async {
    final title = textController.text.trim();
    if (title.isEmpty || saving.value) return;
    saving.value = true;
    try {
      await _db.updateTask(task.id, title: title, status: status.value);
      Get.back();
    } catch (e) {
      saving.value = false;
      Get.snackbar('Error', 'Failed to save: $e');
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
