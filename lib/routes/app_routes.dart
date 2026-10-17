import 'package:get/get.dart';

import '../controllers/add_task_controller.dart';
import '../controllers/edit_task_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/welcome_controller.dart';
import '../screens/add_task_screen.dart';
import '../screens/edit_task_screen.dart';
import '../screens/home_screen.dart';
import '../screens/welcome_screen.dart';

class AppRoutes {
  static const welcome = '/welcome';
  static const home = '/home';
  static const addTask = '/add-task';
  static const editTask = '/edit-task';

  static final pages = <GetPage>[
    GetPage(
      name: welcome,
      page: () => const WelcomeScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => WelcomeController())),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => HomeController())),
    ),
    GetPage(
      name: addTask,
      page: () => const AddTaskScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AddTaskController())),
    ),
    GetPage(
      name: editTask,
      page: () => const EditTaskScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => EditTaskController())),
    ),
  ];
}
