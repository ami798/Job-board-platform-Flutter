import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/secure_storage.dart';
import '../routing/app_router.dart';

class AuthGuard {
  static Future<String?> redirectBasedOnRole(
    BuildContext context,
    GoRouterState state,
    List<String> allowedRoles,
  ) async {
    final token = await SecureStorage.getToken();
    final role = await SecureStorage.getUserRole();

    if (token == null) {
      return AppRouter.login;
    }

    if (role == null || !allowedRoles.contains(role)) {
      // Redirect based on role
      switch (role) {
        case 'job_seeker':
          return AppRouter.home;
        case 'employer':
          return AppRouter.employerDashboard;
        case 'admin':
          return AppRouter.adminDashboard;
        default:
          return AppRouter.login;
      }
    }

    return null; // No redirect needed
  }
}
