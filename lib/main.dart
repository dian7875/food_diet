import 'package:flutter/material.dart';
import 'package:food_diet/routes/app_routes.dart';

void main() {
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
