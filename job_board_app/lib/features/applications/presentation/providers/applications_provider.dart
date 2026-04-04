import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../domain/usecases/apply_for_job_usecase.dart';
import '../domain/usecases/get_my_applications_usecase.dart';
import '../domain/usecases/update_application_status_usecase.dart';
import '../domain/entities/application_entity.dart';

// Providers
final applicationsRepositoryProvider = Provider<ApplicationsRepository>((ref) {
  throw UnimplementedError();
});

final applyForJobUsecaseProvider = Provider<ApplyForJobUsecase>((ref) {
  final repository = ref.watch(applicationsRepositoryProvider);
  return ApplyForJobUsecase(repository);
});

final getMyApplicationsUsecaseProvider = Provider<GetMyApplicationsUsecase>((
  ref,
) {
  final repository = ref.watch(applicationsRepositoryProvider);
  return GetMyApplicationsUsecase(repository);
});

final updateApplicationStatusUsecaseProvider =
    Provider<UpdateApplicationStatusUsecase>((ref) {
      final repository = ref.watch(applicationsRepositoryProvider);
      return UpdateApplicationStatusUsecase(repository);
    });

// State
class ApplicationsState {
  final bool isLoading;
  final List<ApplicationEntity> applications;
  final ApplicationEntity? selectedApplication;
  final String? error;

  const ApplicationsState({
    this.isLoading = false,
    this.applications = const [],
    this.selectedApplication,
    this.error,
  });

  ApplicationsState copyWith({
    bool? isLoading,
    List<ApplicationEntity>? applications,
    ApplicationEntity? selectedApplication,
    String? error,
  }) {
    return ApplicationsState(
      isLoading: isLoading ?? this.isLoading,
      applications: applications ?? this.applications,
      selectedApplication: selectedApplication ?? this.selectedApplication,
      error: error ?? this.error,
    );
  }
}

class ApplicationsNotifier extends Notifier<ApplicationsState> {
  @override
  ApplicationsState build() {
    return const ApplicationsState();
  }

  Future<void> getMyApplications() async {
    state = state.copyWith(isLoading: true, error: null);
    final usecase = ref.read(getMyApplicationsUsecaseProvider);
    final result = await usecase();

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (applications) {
        state = state.copyWith(isLoading: false, applications: applications);
      },
    );
  }

  Future<void> applyForJob(String jobId, {String? cvUrl}) async {
    state = state.copyWith(isLoading: true, error: null);
    final usecase = ref.read(applyForJobUsecaseProvider);
    final result = await usecase(jobId, cvUrl: cvUrl);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (application) {
        state = state.copyWith(isLoading: false);
        // Optionally add to list
      },
    );
  }

  Future<void> updateApplicationStatus(String id, String status) async {
    final usecase = ref.read(updateApplicationStatusUsecaseProvider);
    final result = await usecase(id, status);

    result.fold(
      (failure) {
        // Handle error
      },
      (application) {
        // Update in list
        final updatedApplications = state.applications.map((app) {
          return app.id == id ? application : app;
        }).toList();
        state = state.copyWith(applications: updatedApplications);
      },
    );
  }
}

final applicationsProvider =
    NotifierProvider<ApplicationsNotifier, ApplicationsState>(
      ApplicationsNotifier.new,
    );
