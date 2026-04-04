import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/register_request_model.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call(LoginRequestModel request) async {
    try {
      final result = await repository.login(request);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call(RegisterRequestModel request) async {
    try {
      final result = await repository.register(request);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class LogoutUsecase {
  Future<Either<Failure, void>> call() async {
    // Implement logout logic
    return const Right(null);
  }
}
