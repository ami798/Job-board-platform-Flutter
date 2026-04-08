import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/application_entity.dart';
import '../repositories/applications_repository.dart';

class ApplyForJobUsecase {
  final ApplicationsRepository repository;

  ApplyForJobUsecase(this.repository);

  Future<Either<Failure, ApplicationEntity>> call(
    String jobId, {
    String? cvUrl,
  }) async {
    try {
      final result = await repository.applyForJob(jobId, cvUrl: cvUrl);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class GetMyApplicationsUsecase {
  final ApplicationsRepository repository;

  GetMyApplicationsUsecase(this.repository);

  Future<Either<Failure, List<ApplicationEntity>>> call() async {
    try {
      final result = await repository.getMyApplications();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class UpdateApplicationStatusUsecase {
  final ApplicationsRepository repository;

  UpdateApplicationStatusUsecase(this.repository);

  Future<Either<Failure, ApplicationEntity>> call(
    String id,
    String status,
  ) async {
    try {
      final result = await repository.updateApplicationStatus(id, status);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
