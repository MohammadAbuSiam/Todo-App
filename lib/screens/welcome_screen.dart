import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/welcome_controller.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tudoo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Text("Let's get started",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('What should we call you?',
                style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 16),
            TextField(
              onChanged: (v) => controller.name.value = v,
              decoration: const InputDecoration(hintText: 'Your name'),
              onSubmitted: (_) => controller.save(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
