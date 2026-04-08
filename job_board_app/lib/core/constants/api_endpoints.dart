class ApiEndpoints {
  static const String baseUrl = 'https://your-backend-url.com/api';

  // Auth
  static const String register = '/auth/register';
  static const String login = '/auth/login';

  // Jobs
  static const String jobs = '/jobs';
  static String jobDetails(String id) => '/jobs/$id';

  // Applications
  static const String applications = '/applications';
  static String applicationDetails(String id) => '/applications/$id';

  // Employer Request
  static const String employerRequest = '/employer-request';
  static const String employerRequestStatus = '/employer-request/status';
  static const String approveEmployerRequest = '/admin/approve-request';

  // Users
  static const String users = '/users';
  static String userDetails(String id) => '/users/$id';
}
