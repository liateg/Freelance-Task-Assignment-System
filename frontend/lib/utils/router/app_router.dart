import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../layout/main_shell.dart';
import '../../features/settings/settings_screen.dart';

import '../../features/items/presentation/screens/create_item_screen.dart';
import '../../features/items/presentation/screens/admin_item_list_screen.dart';
import '../../features/items/presentation/screens/claim_item_screen.dart'; 
import '../../features/items/presentation/screens/item_detail_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',

  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainShell(child: child);
      },

      routes: [
        GoRoute(path: '/home', builder: (context, state) => const ClaimsScreen()),

        GoRoute(
          path: '/post',
          builder: (context, state) => const CreateItemScreen(),
        ),

        GoRoute(
          path: '/items',
          builder: (context, state) => const AdminItemListScreen(),

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
