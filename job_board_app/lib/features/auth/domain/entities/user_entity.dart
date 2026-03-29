// lib/features/auth/domain/entities/user_entity.dart
enum UserRole { jobSeeker, employer, admin, pendingEmployer }

class UserEntity {
  final String id;
  final String email;
  final UserRole role;
  final String? employerStatus;

  UserEntity({
    required this.id,
    required this.email,
    required this.role,
    this.employerStatus,
  });
}
