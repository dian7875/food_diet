import 'package:food_diet/features/Dashboard/dashboard.dart';
import 'package:food_diet/features/Auth/pages/welcome_page.dart';
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
            GoRoute(path: '/dashboard', builder: (context, state) => const Dashboard()),
        ],
      ),
    ],
  );
}
