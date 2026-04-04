import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

enum UserRole {
  @JsonValue('job_seeker')
  jobSeeker,
  @JsonValue('employer')
  employer,
  admin,
}

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String name,
    required String email,
    required UserRole role,
  }) = _UserEntity;
}
