import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/job_entity.dart';
import '../repositories/jobs_repository.dart';

class GetJobsUsecase {
  final JobsRepository repository;

  GetJobsUsecase(this.repository);

  Future<Either<Failure, List<JobEntity>>> call({
    String? search,
    String? location,
    double? minSalary,
  }) async {
    try {
      final result = await repository.getJobs(
        search: search,
        location: location,
        minSalary: minSalary,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class GetJobDetailsUsecase {
  final JobsRepository repository;

  GetJobDetailsUsecase(this.repository);

  Future<Either<Failure, JobEntity>> call(String id) async {
    try {
      final result = await repository.getJobDetails(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class SearchJobsUsecase {
  final JobsRepository repository;

  SearchJobsUsecase(this.repository);

  Future<Either<Failure, List<JobEntity>>> call(String query) async {
    try {
      final result = await repository.getJobs(search: query);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
