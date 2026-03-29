// lib/features/auth/data/datasources/auth_remote_datasource.dart

import 'package:dio/dio.dart';
import '../models/auth_models.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(
    String name,
    String email,
    String password,
    String role,
  );
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl({required this.dio});

  static const String _basePath = '/api/auth';

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await dio.post(
        '$_basePath/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponse.fromJson(response.data as Map<String, dynamic>);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected login response status: ${response.statusCode}',
      );
    } on DioException catch (e) {
      throw Exception('Login failed: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AuthResponse> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    try {
      final response = await dio.post(
        '$_basePath/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponse.fromJson(response.data as Map<String, dynamic>);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected register response status: ${response.statusCode}',
      );
    } on DioException catch (e) {
      throw Exception('Register failed: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Register failed: $e');
    }
  }
}
