import '../models/job_model.dart';

abstract class JobsRepository {
  Future<List<JobModel>> getJobs({
    String? search,
    String? location,
    double? minSalary,
  });
  Future<JobModel> getJobDetails(String id);
}
