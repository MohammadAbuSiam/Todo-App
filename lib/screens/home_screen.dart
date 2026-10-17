import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../core/app_theme.dart';
import '../models/task_model.dart';
import '../routes/app_routes.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tudoo')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () => Get.toNamed(AppRoutes.addTask),
        child: const Icon(Icons.note_add_outlined),
      ),
      body: Obx(() {
        if (controller.error.value != null) {
          return Center(child: Text('Error: ${controller.error.value}'));
        }
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final tasks = controller.tasks;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SummaryCard(
              userName: controller.userName.value,
              doneCount: controller.doneCount,
              todoCount: controller.todoCount,
            ),
            const SizedBox(height: 12),
            if (tasks.isEmpty)
              const _EmptyCard()
            else
              ...tasks.map((t) => _TaskTile(task: t)),
          ],
        );
      }),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String userName;
  final int doneCount;
  final int todoCount;
  const _SummaryCard({
    required this.userName,
    required this.doneCount,
    required this.todoCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome $userName', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _StatBox(
                    color: AppColors.done,
                    icon: Icons.check_circle_outline,
                    count: doneCount,
                    label: 'Done'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StatBox(
                    color: AppColors.todo,
                    icon: Icons.sticky_note_2_outlined,
                    count: todoCount,
                    label: 'To Do'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final Color color;
  final IconData icon;
  final int count;
  final String label;
  const _StatBox({
    required this.color,
    required this.icon,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 4),
          Text('$count',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 11)),
        ],
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('No tasks for today!',
              style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          Text('Tap the + button to add your first one.',
              style: TextStyle(color: Colors.black54, fontSize: 12)),
        ],
      ),
    );
  }
}

class _TaskTile extends GetView<HomeController> {
  final TaskModel task;
  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    final color = task.isDone ? AppColors.done : AppColors.todo;

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.only(right: 16),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => controller.deleteTask(task.id),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => Get.toNamed(AppRoutes.editTask, arguments: task),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(task.isDone ? 'Done' : 'TODO',
                    style: const TextStyle(color: Colors.white, fontSize: 10)),
              ),
              const SizedBox(height: 8),
              Text(task.title, style: const TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
