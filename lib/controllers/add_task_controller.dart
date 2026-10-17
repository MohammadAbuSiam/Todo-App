import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../database/tasks_database.dart';

class AddTaskController extends GetxController {
  final _db = TasksDatabase();
  final textController = TextEditingController();
  final saving = false.obs;

  Future<void> save() async {
    final title = textController.text.trim();
    if (title.isEmpty || saving.value) return;
    saving.value = true;
    try {
      await _db.addTask(title);
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
