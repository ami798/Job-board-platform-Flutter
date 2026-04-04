import 'package:dio/dio.dart';
import '../../../../core/api/api_service.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/job_model.dart';

abstract class JobsRemoteDataSource {
  Future<List<JobModel>> getJobs({
    String? search,
    String? location,
    double? minSalary,
  });
  Future<JobModel> getJobDetails(String id);
}

class JobsRemoteDataSourceImpl implements JobsRemoteDataSource {
  final ApiService apiService;

  JobsRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<JobModel>> getJobs({
    String? search,
    String? location,
    double? minSalary,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (search != null) queryParams['search'] = search;
      if (location != null) queryParams['location'] = location;
      if (minSalary != null) queryParams['minSalary'] = minSalary;

      final response = await apiService.get(
        ApiEndpoints.jobs,
        queryParameters: queryParams,
      );
      return (response.data as List)
          .map((json) => JobModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch jobs');
    }
  }

  @override
  Future<JobModel> getJobDetails(String id) async {
    try {
      final response = await apiService.get(ApiEndpoints.jobDetails(id));
      return JobModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch job details');
    }
  }
}
