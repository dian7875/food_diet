import 'package:food_diet/features/Profile/Pages/profile.dart';
import 'package:food_diet/features/Dashboard/dashboard.dart';
import 'package:food_diet/features/Auth/pages/welcome_page.dart';
import 'package:food_diet/features/Auth/pages/forgot_password_screen_new.dart' as fp;
import 'package:food_diet/features/Auth/pages/register_screen.dart';
import 'package:food_diet/features/Profile/screens/login.dart';
import 'package:food_diet/features/MyMenu/pages/my_foods.dart';
import 'package:food_diet/features/MyMenu/screens/breackfast_foods.dart';
import 'package:food_diet/features/MyMenu/screens/dinner_foods.dart';
import 'package:food_diet/features/MyMenu/screens/lunch_foods.dart';
import 'package:food_diet/features/MyMenu/screens/snacks.dart';
import 'package:food_diet/features/Profile/screens/special_needs.dart';
import 'package:food_diet/layout/main_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static GoRouter get router => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const WelcomePage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/forgot-password', builder: (context, state) => const fp.ForgotPasswordScreen()),
      ShellRoute(        builder: (context, state, child) {
          // Siempre permite acceso, sin verificación de autenticación
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
            routes: [
              GoRoute(
                path: 'special-needs',
                builder: (context, state) => SpecialNeedsScreen(),
              ),
            ],
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
