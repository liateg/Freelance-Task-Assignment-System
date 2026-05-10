import 'package:go_router/go_router.dart';

import '../layout/main_shell.dart';

import '../../features/admin/admin_categories_screen.dart';
import '../../features/admin/admin_claim_detail_screen.dart';
import '../../features/admin/admin_claims_screen.dart';
import '../../features/admin/admin_dashboard.dart';
import '../../features/admin/admin_items_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/claims/presentation/screens/claim_detail_screen.dart';
import '../../features/claims/presentation/screens/claim_empty.dart';
import '../../features/claims/presentation/screens/claim_item_detail_screen.dart';
import '../../features/claims/presentation/screens/claim_screen.dart';
import '../../features/home/home.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features2/data/mock/mock_feedback_reports.dart';
import '../../features2/presentation/screens/adminPages/admin_report.dart'
    as admin_reports_v2;
import '../../features2/presentation/screens/adminPages/admin_report_details.dart';
import '../../features2/presentation/screens/adminPages/admin_reports_all_screen.dart';
import 'route_paths.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.splash,
  routes: [
    GoRoute(
      path: RoutePaths.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePaths.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/admin-dashboard',
      redirect: (context, state) => RoutePaths.adminDashboard,
    ),
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: RoutePaths.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RoutePaths.post,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: RoutePaths.items,
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: RoutePaths.claims,
          builder: (context, state) => const ClaimsScreen(),
          routes: [
            GoRoute(
              path: 'empty',
              builder: (context, state) => const ClaimEmptyScreen(),
            ),
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return ClaimDetailScreen(claimId: id);
              },
              routes: [
                GoRoute(
                  path: 'item/:itemId',
                  builder: (context, state) {
                    final itemId = state.pathParameters['itemId']!;
                    return ClaimItemDetailScreen(itemId: itemId);
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: RoutePaths.adminDashboard,
          builder: (context, state) => const AdminDashboard(),
        ),
        GoRoute(
          path: RoutePaths.adminItems,
          builder: (context, state) => const AdminItemsScreen(),
        ),
        GoRoute(
          path: RoutePaths.adminClaims,
          builder: (context, state) => const AdminClaimsScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return AdminClaimDetailScreen(claimId: id);
              },
            ),
          ],
        ),
        GoRoute(
          path: RoutePaths.adminReports,
          builder: (context, state) =>
              const admin_reports_v2.AdminReportsScreen(),
          routes: [
            GoRoute(
              path: 'all',
              builder: (context, state) => const AdminReportsAllScreen(),
            ),
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final extra = state.extra;
                final report = extra is FeedbackReportMock
                    ? extra
                    : kMockFeedbackReports.firstWhere(
                        (e) => e.id == state.pathParameters['id'],
                        orElse: () => kMockFeedbackReports.first,
                      );
                return AdminReportsDetailScreen(report: report);
              },
            ),
          ],
        ),
        GoRoute(
          path: RoutePaths.adminCategories,
          builder: (context, state) => const AdminCategoriesScreen(),
        ),
      ],
    ),
  ],
);

final GoRouter router = appRouter;
