import 'package:food_diet/features/Auth/pages/profile.dart';
import 'package:food_diet/features/Dashboard/dashboard.dart';
import 'package:food_diet/features/Auth/pages/welcome_page.dart';
import 'package:food_diet/features/MyMenu/pages/my_foods.dart';
import 'package:food_diet/features/MyMenu/screens/breackfast_foods.dart';
import 'package:food_diet/features/MyMenu/screens/dinner_foods.dart';
import 'package:food_diet/features/MyMenu/screens/lunch_foods.dart';
import 'package:food_diet/features/MyMenu/screens/snacks.dart';
import 'package:food_diet/layout/main_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static GoRouter get router => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const WelcomePage()),
      ShellRoute(
        builder: (context, state, child) {
          return MainScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const Dashboard(),
          ),
          GoRoute(
            path: '/MyProfile',
            builder: (context, state) => const MyProfileScreen(),
          ),
          GoRoute(
            path: '/MyFoods',
            builder: (context, state) => const MyFoods(),
            routes: [
              GoRoute(
                path: 'breakfast',
                builder: (context, state) => const BreakfastFoodsScreen(),
              ),
              GoRoute(
                path: 'lunch',
                builder: (context, state) => const LunchFoodsScreen(),
              ),
              GoRoute(
                path: 'dinner',
                builder: (context, state) => const DinnerFoodsScreen(),
              ),
              GoRoute(
                path: 'snack',
                builder: (context, state) => const SnacksScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
