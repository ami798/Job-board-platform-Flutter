import 'package:dio/dio.dart';
import '../models/auth_models.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(
    String name,
    String email,
    String password,
    String role,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<AuthResponse> login(String email, String password) async {
    final response = await _dio.post(
      '/api/auth/login',
      data: {'email': email, 'password': password},
    );
    return AuthResponse.fromJson(response.data);
  }

  @override
  Future<AuthResponse> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    final response = await _dio.post(
      '/api/auth/register',
      data: {'name': name, 'email': email, 'password': password, 'role': role},
    );
    return AuthResponse.fromJson(response.data);
  }
}
