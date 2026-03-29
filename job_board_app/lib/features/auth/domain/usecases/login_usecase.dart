// lib/features/auth/domain/usecases/login_usecase.dart

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call(String email, String password) async {
    // Input validation should happen at ViewModel layer; domain use case focuses on business logic.
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required.');
    }
    return await repository.login(email, password);
  }
}
