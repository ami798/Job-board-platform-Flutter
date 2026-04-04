import '../../domain/repositories/jobs_repository.dart';
import '../datasources/jobs_remote_data_source.dart';
import '../models/job_model.dart';

class JobsRepositoryImpl implements JobsRepository {
  final JobsRemoteDataSource remoteDataSource;

  JobsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<JobModel>> getJobs({
    String? search,
    String? location,
    double? minSalary,
  }) async {
    return await remoteDataSource.getJobs(
      search: search,
      location: location,
      minSalary: minSalary,
    );
  }

  @override
  Future<JobModel> getJobDetails(String id) async {
    return await remoteDataSource.getJobDetails(id);
  }
}
