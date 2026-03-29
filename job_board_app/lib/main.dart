// lib/main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize storage, firebase, etc.
  runApp(const ProviderScope(child: JobBoardApp()));
}

// lib/app.dart
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
