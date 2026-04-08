import 'package:dio/dio.dart';
import 'dio_client.dart';
import 'interceptors/auth_interceptor.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = DioClient().dio;
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path) async {
    return _dio.delete(path);
  }
}
