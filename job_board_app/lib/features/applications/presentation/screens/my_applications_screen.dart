import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/common_widgets/loading_widget.dart';
import '../../../../core/common_widgets/error_widget.dart';
import '../providers/applications_provider.dart';

class MyApplicationsScreen extends ConsumerStatefulWidget {
  const MyApplicationsScreen({super.key});

  @override
  ConsumerState<MyApplicationsScreen> createState() =>
      _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends ConsumerState<MyApplicationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(applicationsProvider.notifier).getMyApplications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final applicationsState = ref.watch(applicationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.applications)),
      body: applicationsState.isLoading
          ? const LoadingWidget()
          : applicationsState.error != null
          ? ErrorWidget(
              message: applicationsState.error!,
              onRetry: () =>
                  ref.read(applicationsProvider.notifier).getMyApplications(),
            )
          : applicationsState.applications.isEmpty
          ? const Center(child: Text(AppStrings.noApplicationsFound))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: applicationsState.applications.length,
              itemBuilder: (context, index) {
                final application = applicationsState.applications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text('Application ${application.id}'),
                    subtitle: Text('Status: ${application.status}'),
                    trailing: _getStatusIcon(application.status),
                  ),
                );
              },
            ),
    );
  }

  Widget _getStatusIcon(String status) {
    switch (status) {
      case 'submitted':
        return const Icon(Icons.pending, color: AppColors.warning);
      case 'in_review':
        return const Icon(Icons.hourglass_top, color: AppColors.warning);
      case 'accepted':
        return const Icon(Icons.check_circle, color: AppColors.success);
      case 'rejected':
        return const Icon(Icons.cancel, color: AppColors.error);
      default:
        return const Icon(Icons.help);
    }
  }
}
