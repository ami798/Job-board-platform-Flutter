// lib/features/auth/data/repositories/auth_repository_impl.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.secureStorage,
  });

  static const String _tokenKey = 'auth_token';

  @override
  Future<User> login(String email, String password) async {
    final authResponse = await remoteDatasource.login(email, password);
    await secureStorage.write(key: _tokenKey, value: authResponse.token);
    return authResponse.user.toEntity();
  }

  @override
  Future<User> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    final authResponse = await remoteDatasource.register(
      name,
      email,
      password,
      role,
    );
    await secureStorage.write(key: _tokenKey, value: authResponse.token);
    return authResponse.user.toEntity();
  }

  // Future extension for logout and token retrieval can be added here.
}
