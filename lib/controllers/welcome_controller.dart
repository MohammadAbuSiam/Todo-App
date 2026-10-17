import 'package:get/get.dart';

import '../database/local_storage.dart';
import '../routes/app_routes.dart';

class WelcomeController extends GetxController {
  final _storage = LocalStorage();
  final name = ''.obs;

  Future<void> save() async {
    final value = name.value.trim();
    if (value.isEmpty) return;
    await _storage.saveUserName(value);
    Get.offAllNamed(AppRoutes.home);
  }
}
