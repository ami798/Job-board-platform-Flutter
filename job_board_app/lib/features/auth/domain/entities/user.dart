// lib/features/auth/domain/entities/user.dart

enum UserRole { jobSeeker, employer, admin }

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.jobSeeker:
        return 'job_seeker';
      case UserRole.employer:
        return 'employer';
      case UserRole.admin:
        return 'admin';
    }
  }

  static UserRole fromString(String value) {
    switch (value.toLowerCase()) {
      case 'employer':
        return UserRole.employer;
      case 'job_seeker':
      case 'jobseeker':
      case 'job seeker':
        return UserRole.jobSeeker;
      case 'admin':
        return UserRole.admin;
      default:
        throw ArgumentError('Invalid user role: $value');
    }
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}
