import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_task_controller.dart';

class AddTaskScreen extends GetView<AddTaskController> {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tudoo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Task',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: controller.textController,
              maxLines: 2,
              decoration:
                  const InputDecoration(hintText: 'What needs to be done?'),
            ),
            const SizedBox(height: 16),
            Obx(() => ElevatedButton(
                  onPressed: controller.saving.value ? null : controller.save,
                  child: const Text('Save'),
                )),
          ],
        ),
      ),
    );
  }
}
