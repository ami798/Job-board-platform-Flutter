import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/jobs/presentation/screens/home_screen.dart';
import '../../features/jobs/presentation/screens/job_details_screen.dart';
import '../../features/applications/presentation/screens/apply_screen.dart';
import '../../features/applications/presentation/screens/my_applications_screen.dart';
import '../../features/employer/presentation/screens/employer_dashboard_screen.dart';
import '../../features/employer/presentation/screens/post_job_screen.dart';
import '../../features/employer/presentation/screens/manage_jobs_screen.dart';
import '../../features/employer/presentation/screens/view_applicants_screen.dart';
import '../../features/employer_request/presentation/screens/apply_to_be_employer_screen.dart';
import '../../features/employer_request/presentation/screens/employer_request_status_screen.dart';
import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/admin/presentation/screens/user_management_screen.dart';
import '../../features/admin/presentation/screens/job_management_screen.dart';
import '../../features/admin/presentation/screens/employer_approval_panel_screen.dart';
import 'guards/auth_guard.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String jobDetails = '/job-details';
  static const String apply = '/apply';
  static const String myApplications = '/my-applications';
  static const String employerDashboard = '/employer-dashboard';
  static const String postJob = '/post-job';
  static const String manageJobs = '/manage-jobs';
  static const String viewApplicants = '/view-applicants';
  static const String applyToBeEmployer = '/apply-to-be-employer';
  static const String employerRequestStatus = '/employer-request-status';
  static const String adminDashboard = '/admin-dashboard';
  static const String userManagement = '/user-management';
  static const String jobManagement = '/job-management';
  static const String employerApproval = '/employer-approval';

  GoRouter get router => GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['job_seeker']),
      ),
      GoRoute(
        path: '$jobDetails/:id',
        builder: (context, state) =>
            JobDetailsScreen(jobId: state.pathParameters['id']!),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['job_seeker']),
      ),
      GoRoute(
        path: '$apply/:id',
        builder: (context, state) =>
            ApplyScreen(jobId: state.pathParameters['id']!),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['job_seeker']),
      ),
      GoRoute(
        path: myApplications,
        builder: (context, state) => const MyApplicationsScreen(),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['job_seeker']),
      ),
      GoRoute(
        path: applyToBeEmployer,
        builder: (context, state) => const ApplyToBeEmployerScreen(),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['job_seeker']),
      ),
      GoRoute(
        path: employerRequestStatus,
        builder: (context, state) => const EmployerRequestStatusScreen(),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['job_seeker']),
      ),
      GoRoute(
        path: employerDashboard,
        builder: (context, state) => const EmployerDashboardScreen(),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['employer']),
      ),
      GoRoute(
        path: postJob,
        builder: (context, state) => const PostJobScreen(),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['employer']),
      ),
      GoRoute(
        path: manageJobs,
        builder: (context, state) => const ManageJobsScreen(),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['employer']),
      ),
      GoRoute(
        path: '$viewApplicants/:id',
        builder: (context, state) =>
            ViewApplicantsScreen(jobId: state.pathParameters['id']!),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['employer']),
      ),
      GoRoute(
        path: adminDashboard,
        builder: (context, state) => const AdminDashboardScreen(),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['admin']),
      ),
      GoRoute(
        path: userManagement,
        builder: (context, state) => const UserManagementScreen(),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['admin']),
      ),
      GoRoute(
        path: jobManagement,
        builder: (context, state) => const JobManagementScreen(),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['admin']),
      ),
      GoRoute(
        path: employerApproval,
        builder: (context, state) => const EmployerApprovalPanelScreen(),
        redirect: (context, state) =>
            AuthGuard.redirectBasedOnRole(context, state, ['admin']),
      ),
    ],
  );
}
