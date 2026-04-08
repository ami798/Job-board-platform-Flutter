import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/common_widgets/loading_widget.dart';
import '../../../../core/common_widgets/error_widget.dart';
import '../../../../core/widgets/job_card.dart';
import '../providers/jobs_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedLocation;
  double? _minSalary;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(jobsProvider.notifier).getJobs();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobsState = ref.watch(jobsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: AppStrings.search,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  ref.read(jobsProvider.notifier).searchJobs(value);
                } else {
                  ref.read(jobsProvider.notifier).getJobs();
                }
              },
            ),
          ),
          Expanded(
            child: jobsState.isLoading
                ? const LoadingWidget()
                : jobsState.error != null
                ? ErrorWidget(
                    message: jobsState.error!,
                    onRetry: () => ref.read(jobsProvider.notifier).getJobs(),
                  )
                : jobsState.jobs.isEmpty
                ? const Center(child: Text(AppStrings.noJobsFound))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: jobsState.jobs.length,
                    itemBuilder: (context, index) {
                      final job = jobsState.jobs[index];
                      return JobCard(
                        job: job,
                        onTap: () =>
                            context.go('${AppRouter.jobDetails}/${job.id}'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.filter),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: AppStrings.location),
              onChanged: (value) =>
                  _selectedLocation = value.isEmpty ? null : value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: AppStrings.salary),
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  _minSalary = value.isEmpty ? null : double.tryParse(value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(jobsProvider.notifier)
                  .getJobs(location: _selectedLocation, minSalary: _minSalary);
              Navigator.of(context).pop();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}
