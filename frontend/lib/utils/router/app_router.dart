import 'package:go_router/go_router.dart';

import '../layout/main_shell.dart';

import '../../features/home/home.dart';
import '../../features/claims/presentation/screens/claim_detail_screen.dart';
import '../../features/claims/presentation/screens/claim_screen.dart';
import '../../features/claims/presentation/screens/claim_empty.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/admin/admin_dashboard.dart';
import '../../features/reports/reports_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',

  routes: [
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
          builder: (context, state) => const ClaimsScreen(),
        ),
        GoRoute(
          path: '/admin/claims',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/admin/reports',
          builder: (context, state) => const ReportsScreen(),
        ),
      ],
    ),
  ],
);
