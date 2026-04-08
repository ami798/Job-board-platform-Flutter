import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../domain/usecases/get_jobs_usecase.dart';
import '../domain/usecases/get_job_details_usecase.dart';
import '../domain/usecases/search_jobs_usecase.dart';
import '../domain/entities/job_entity.dart';

// Providers
final jobsRepositoryProvider = Provider<JobsRepository>((ref) {
  throw UnimplementedError();
});

final getJobsUsecaseProvider = Provider<GetJobsUsecase>((ref) {
  final repository = ref.watch(jobsRepositoryProvider);
  return GetJobsUsecase(repository);
});

final getJobDetailsUsecaseProvider = Provider<GetJobDetailsUsecase>((ref) {
  final repository = ref.watch(jobsRepositoryProvider);
  return GetJobDetailsUsecase(repository);
});

final searchJobsUsecaseProvider = Provider<SearchJobsUsecase>((ref) {
  final repository = ref.watch(jobsRepositoryProvider);
  return SearchJobsUsecase(repository);
});

// State
class JobsState {
  final bool isLoading;
  final List<JobEntity> jobs;
  final JobEntity? selectedJob;
  final String? error;

  const JobsState({
    this.isLoading = false,
    this.jobs = const [],
    this.selectedJob,
    this.error,
  });

  JobsState copyWith({
    bool? isLoading,
    List<JobEntity>? jobs,
    JobEntity? selectedJob,
    String? error,
  }) {
    return JobsState(
      isLoading: isLoading ?? this.isLoading,
      jobs: jobs ?? this.jobs,
      selectedJob: selectedJob ?? this.selectedJob,
      error: error ?? this.error,
    );
  }
}

class JobsNotifier extends Notifier<JobsState> {
  @override
  JobsState build() {
    return const JobsState();
  }

  Future<void> getJobs({
    String? search,
    String? location,
    double? minSalary,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    final usecase = ref.read(getJobsUsecaseProvider);
    final result = await usecase(
      search: search,
      location: location,
      minSalary: minSalary,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (jobs) {
        state = state.copyWith(isLoading: false, jobs: jobs);
      },
    );
  }

  Future<void> getJobDetails(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    final usecase = ref.read(getJobDetailsUsecaseProvider);
    final result = await usecase(id);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (job) {
        state = state.copyWith(isLoading: false, selectedJob: job);
      },
    );
  }

  Future<void> searchJobs(String query) async {
    state = state.copyWith(isLoading: true, error: null);
    final usecase = ref.read(searchJobsUsecaseProvider);
    final result = await usecase(query);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (jobs) {
        state = state.copyWith(isLoading: false, jobs: jobs);
      },
    );
  }
}

final jobsProvider = NotifierProvider<JobsNotifier, JobsState>(
  JobsNotifier.new,
);
