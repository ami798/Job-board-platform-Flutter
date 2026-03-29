// lib/routing/app_router.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:job_board_app/features/auth/presentation/screens/login_screen.dart';
import 'package:job_board_app/features/auth/presentation/screens/register_screen.dart';
import 'package:job_board_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:job_board_app/features/auth/domain/entities/user.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggedIn = authState.user != null;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');

      if (!isLoggedIn && !isAuthRoute) return '/auth/login';
      if (isLoggedIn && isAuthRoute) return '/home';

      // Role Guard for Admin/Employer Dashboard
      if (state.matchedLocation.startsWith('/admin') &&
          authState.user?.role != UserRole.admin &&
          authState.user?.role != UserRole.employer) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/admin/dashboard',
            builder: (context, state) => const AdminDashboardScreen(),
          ),
          // ... remaining 15+ routes
        ],
      ),
    ],
  );
});
