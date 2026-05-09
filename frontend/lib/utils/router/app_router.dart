import 'package:go_router/go_router.dart';

import '../layout/main_shell.dart';

import '../../features/home/home.dart';
import '../../features/claims/presentation/screens/claim_detail_screen.dart';
import '../../features/claims/presentation/screens/claim_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/settings/settings_screen.dart';

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
          path: '/items',
          builder: (context, state) => const ClaimsScreen(),

          routes: [
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
          path: '/claims',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
