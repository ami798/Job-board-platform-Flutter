import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Note: If 'job_board_app' is not your project name in pubspec.yaml,
// change it to match your actual project name.
import 'package:job_board_app/core/theme/app_theme.dart';
import 'package:job_board_app/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: JobBoardApp()));
}

class JobBoardApp extends ConsumerWidget {
  const JobBoardApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Job Board Platform',
      theme: AppTheme.light,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
