import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/common_widgets/loading_widget.dart';
import '../../../../core/common_widgets/error_widget.dart';
import '../../../../core/common_widgets/app_button.dart';
import '../providers/jobs_provider.dart';

class JobDetailsScreen extends ConsumerStatefulWidget {
  final String jobId;

  const JobDetailsScreen({super.key, required this.jobId});

  @override
  ConsumerState<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends ConsumerState<JobDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(jobsProvider.notifier).getJobDetails(widget.jobId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobsState = ref.watch(jobsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Job Details')),
      body: jobsState.isLoading
          ? const LoadingWidget()
          : jobsState.error != null
          ? ErrorWidget(
              message: jobsState.error!,
              onRetry: () =>
                  ref.read(jobsProvider.notifier).getJobDetails(widget.jobId),
            )
          : jobsState.selectedJob == null
          ? const Center(child: Text('Job not found'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobsState.selectedJob!.title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    jobsState.selectedJob!.company,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 8),
                      Text(jobsState.selectedJob!.location),
                      const SizedBox(width: 16),
                      const Icon(Icons.attach_money),
                      const SizedBox(width: 8),
                      Text('\$${jobsState.selectedJob!.salary}'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppStrings.description,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(jobsState.selectedJob!.description),
                  const SizedBox(height: 24),
                  Text(
                    AppStrings.requirements,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(jobsState.selectedJob!.requirements),
                  const SizedBox(height: 24),
                  Text(
                    AppStrings.benefits,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(jobsState.selectedJob!.benefits),
                  const SizedBox(height: 32),
                  AppButton(
                    text: AppStrings.applyNow,
                    onPressed: () =>
                        context.go('${AppRouter.apply}/${widget.jobId}'),
                  ),
                ],
              ),
            ),
    );
  }
}
