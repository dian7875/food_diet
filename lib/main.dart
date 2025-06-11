import 'package:flutter/material.dart';
import 'package:food_diet/routes/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
Future<void> initHive() async {
  await Hive.initFlutter();
  await Hive.openBox('recipesBox');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FoodDiet',
      theme: ThemeData(primarySwatch: Colors.green),
      routerConfig: AppRoutes.router,
    );
  }
}
