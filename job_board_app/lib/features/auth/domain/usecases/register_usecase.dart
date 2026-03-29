// lib/features/auth/domain/usecases/register_usecase.dart

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User> call(
    String name,
    String email,
    String password,
    String role,
  ) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('Name, email, and password are required.');
    }
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters.');
    }
    return await repository.register(name, email, password, role);
  }
}
