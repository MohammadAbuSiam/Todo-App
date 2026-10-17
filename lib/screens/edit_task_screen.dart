import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/edit_task_controller.dart';
import '../core/app_theme.dart';
import '../models/task_model.dart';

class EditTaskScreen extends GetView<EditTaskController> {
  const EditTaskScreen({super.key});

  Widget _statusButton(TaskStatus value, String label, Color color) {
    return Expanded(
      child: Obx(() {
        final selected = controller.status.value == value;
        return ElevatedButton(
          onPressed: () => controller.status.value = value,
          style: ElevatedButton.styleFrom(
            backgroundColor: selected ? color : color.withValues(alpha: 0.4),
            minimumSize: const Size.fromHeight(36),
          ),
          child: Text(label, style: const TextStyle(fontSize: 12)),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tudoo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit Task',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: controller.textController,
              maxLines: 3,
              decoration: const InputDecoration(hintText: 'Task title'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _statusButton(TaskStatus.todo, 'To Do', AppColors.todo),
                const SizedBox(width: 8),
                _statusButton(TaskStatus.done, 'Done', AppColors.done),
              ],
            ),
            const SizedBox(height: 16),
            Obx(() => ElevatedButton(
                  onPressed: controller.saving.value ? null : controller.save,
                  child: const Text('Save changes'),
                )),
          ],
        ),
      ),
    );
  }
}
