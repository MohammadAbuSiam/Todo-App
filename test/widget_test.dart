import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:todo_app/controllers/welcome_controller.dart';
import 'package:todo_app/core/app_theme.dart';
import 'package:todo_app/screens/welcome_screen.dart';

void main() {
  testWidgets('Welcome screen shows the title', (tester) async {
    Get.put(WelcomeController());

    await tester.pumpWidget(
      GetMaterialApp(theme: AppTheme.light, home: const WelcomeScreen()),
    );

    expect(find.text("Let's get started"), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });
}
