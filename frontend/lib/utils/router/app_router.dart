import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../layout/main_shell.dart';

import '../../features/home/home.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/claims/presentation/screens/claim_detail_screen.dart';
import '../../features/claims/presentation/screens/claim_item_detail_screen.dart';
import '../../features/claims/presentation/screens/claim_screen.dart';
import '../../features/claims/presentation/screens/claim_empty.dart';
import '../../features/claims/presentation/screens/admin.claim_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/admin/admin_dashboard.dart';
import '../../features/admin/admin_items_screen.dart';
import '../../features/reports/reports_screen.dart';
import '../../features2/presentation/screens/adminPages/admin_report.dart';
import '../../features2/presentation/screens/adminPages/admin_reports_all_screen.dart';
import '../../features2/presentation/screens/adminPages/admin_report_details.dart';
import '../../features2/data/mock/mock_feedback_reports.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',

  routes: [

GoRoute(
path: '/splash',
  builder: (context, state) => const SplashScreen(),
),
    GoRoute(
path: '/login',
builder: (context, state) => const LoginScreen(),
),
GoRoute(
path: '/register',
builder: (context, state) => const RegisterScreen(),
),
GoRoute(
path: '/admin-dashboard',
builder: (context, state) => const AdminDashboardScreen(),
),


    ShellRoute(
      builder: (context, state, child) {
        return MainShell(child: child);
      },

      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),

        GoRoute(
          path: '/post',
          builder: (context, state) => const ProfileScreen(),
        ),

        GoRoute(
          path: '/claims',
          builder: (context, state) => const ClaimsScreen(),

          routes: [
            GoRoute(
              path: 'empty',
              builder: (context, state) {
                return const ClaimEmptyScreen();
              },
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
          path: '/items',
          builder: (context, state) => const SettingsScreen(),
        ),

        // Admin routes (share same MainShell but show admin nav)
        GoRoute(
          path: '/admin',
          builder: (context, state) => const AdminDashboard(),
        ),
        GoRoute(
          path: '/admin/items',
          builder: (context, state) => const AdminItemsScreen(),
        ),
        GoRoute(
          path: '/admin/claims',
          builder: (context, state) => const AdminClaimScreen(),
        ),
        GoRoute(
          path: '/admin/reports',
          builder: (context, state) => const AdminReportsScreen(),
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
      ],
    ),
  ],
);
