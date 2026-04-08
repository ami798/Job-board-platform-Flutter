import '../models/application_model.dart';

abstract class ApplicationsRepository {
  Future<List<ApplicationModel>> getMyApplications();
  Future<ApplicationModel> applyForJob(String jobId, {String? cvUrl});
  Future<ApplicationModel> updateApplicationStatus(String id, String status);
}
