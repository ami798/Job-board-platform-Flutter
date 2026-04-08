import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../api/api_service.dart';
import '../network/network_info.dart';
import '../routing/app_router.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/jobs/data/repositories/jobs_repository_impl.dart';
import '../../features/jobs/data/datasources/jobs_remote_data_source.dart';
import '../../features/jobs/domain/repositories/jobs_repository.dart';
import '../../features/applications/data/repositories/applications_repository_impl.dart';
import '../../features/applications/data/datasources/applications_remote_data_source.dart';
import '../../features/applications/domain/repositories/applications_repository.dart';

// Core providers
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final networkInfoProvider = Provider<NetworkInfo>(
  (ref) => NetworkInfoImpl(Connectivity()),
);

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter());

// Auth providers
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRemoteDataSourceImpl(apiService);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
});

// Jobs providers
final jobsRemoteDataSourceProvider = Provider<JobsRemoteDataSource>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return JobsRemoteDataSourceImpl(apiService);
});

final jobsRepositoryProvider = Provider<JobsRepository>((ref) {
  final remoteDataSource = ref.watch(jobsRemoteDataSourceProvider);
  return JobsRepositoryImpl(remoteDataSource);
});

// Applications providers
final applicationsRemoteDataSourceProvider =
    Provider<ApplicationsRemoteDataSource>((ref) {
      final apiService = ref.watch(apiServiceProvider);
      return ApplicationsRemoteDataSourceImpl(apiService);
    });

final applicationsRepositoryProvider = Provider<ApplicationsRepository>((ref) {
  final remoteDataSource = ref.watch(applicationsRemoteDataSourceProvider);
  return ApplicationsRepositoryImpl(remoteDataSource);
});
