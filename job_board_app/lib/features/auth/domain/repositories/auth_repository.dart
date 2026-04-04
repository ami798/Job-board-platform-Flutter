import '../entities/user_entity.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

abstract class AuthRepository {
  Future<UserEntity> login(LoginRequestModel request);
  Future<UserEntity> register(RegisterRequestModel request);
}
