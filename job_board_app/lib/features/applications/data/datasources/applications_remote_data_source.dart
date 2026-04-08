import 'package:dio/dio.dart';
import '../../../../core/api/api_service.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/application_model.dart';

abstract class ApplicationsRemoteDataSource {
  Future<List<ApplicationModel>> getMyApplications();
  Future<ApplicationModel> applyForJob(String jobId, {String? cvUrl});
  Future<ApplicationModel> updateApplicationStatus(String id, String status);
}

class ApplicationsRemoteDataSourceImpl implements ApplicationsRemoteDataSource {
  final ApiService apiService;

  ApplicationsRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<ApplicationModel>> getMyApplications() async {
    try {
      final response = await apiService.get(ApiEndpoints.applications);
      return (response.data as List)
          .map((json) => ApplicationModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch applications');
    }
  }

  @override
  Future<ApplicationModel> applyForJob(String jobId, {String? cvUrl}) async {
    try {
      final data = {'jobId': jobId};
      if (cvUrl != null) data['cvUrl'] = cvUrl;
      final response = await apiService.post(
        ApiEndpoints.applications,
        data: data,
      );
      return ApplicationModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to apply for job');
    }
  }

  @override
  Future<ApplicationModel> updateApplicationStatus(
    String id,
    String status,
  ) async {
    try {
      final response = await apiService.put(
        ApiEndpoints.applicationDetails(id),
        data: {'status': status},
      );
      return ApplicationModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to update application status');
    }
  }
}
