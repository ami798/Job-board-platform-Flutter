import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/common_widgets/app_button.dart';
import '../providers/applications_provider.dart';

class ApplyScreen extends ConsumerStatefulWidget {
  final String jobId;

  const ApplyScreen({super.key, required this.jobId});

  @override
  ConsumerState<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends ConsumerState<ApplyScreen> {
  String? _cvUrl;

  @override
  Widget build(BuildContext context) {
    final applicationsState = ref.watch(applicationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Apply for Job')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Job Details'),
            const SizedBox(height: 16),
            // Job details would be shown here
            const Text('Upload CV (Placeholder)'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Placeholder for CV upload
                setState(() => _cvUrl = 'placeholder_cv_url');
              },
              child: const Text(AppStrings.uploadCV),
            ),
            if (_cvUrl != null) ...[
              const SizedBox(height: 16),
              Text('CV Uploaded: $_cvUrl'),
            ],
            const Spacer(),
            AppButton(
              text: AppStrings.submitApplication,
              isLoading: applicationsState.isLoading,
              onPressed: () {
                ref
                    .read(applicationsProvider.notifier)
                    .applyForJob(widget.jobId, cvUrl: _cvUrl);
                // Navigate back or to success
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
