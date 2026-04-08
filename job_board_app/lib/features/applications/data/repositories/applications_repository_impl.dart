import '../../domain/repositories/applications_repository.dart';
import '../datasources/applications_remote_data_source.dart';
import '../models/application_model.dart';

class ApplicationsRepositoryImpl implements ApplicationsRepository {
  final ApplicationsRemoteDataSource remoteDataSource;

  ApplicationsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ApplicationModel>> getMyApplications() async {
    return await remoteDataSource.getMyApplications();
  }

  @override
  Future<ApplicationModel> applyForJob(String jobId, {String? cvUrl}) async {
    return await remoteDataSource.applyForJob(jobId, cvUrl: cvUrl);
  }

  @override
  Future<ApplicationModel> updateApplicationStatus(
    String id,
    String status,
  ) async {
    return await remoteDataSource.updateApplicationStatus(id, status);
  }
}
