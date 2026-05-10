import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/admin_categories_screen.dart';
import '../../features/admin/admin_claim_detail_screen.dart';
import '../../features/admin/admin_claims_screen.dart';
import '../../features/admin/admin_reports_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/claims/presentation/screens/claim_detail_screen.dart';
import '../../features/claims/presentation/screens/claim_empty.dart';
import '../../features/claims/presentation/screens/claim_item_detail_screen.dart';
import '../../features/claims/presentation/screens/claim_screen.dart';
import '../../features/home/home.dart';
import '../../features/items/admin/adminfilter.dart';
import '../../features/items/categories/filters.dart';
import '../../features/items/create_item_screen.dart';
import '../../features/items/edit_item_screen.dart';
import '../../features/items/item_detail_screen.dart';
import '../../features/items/item_list_screen.dart';
import '../../features/admin/admin_dashboard.dart';
import '../../features/reports/reports_screen.dart';
import '../../utils/layout/main_shell.dart';
import 'route_paths.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.home,

  routes: [
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),

      routes: [
        GoRoute(
          path: RoutePaths.home,
          builder: (context, state) => const HomeScreen(),
        ),

        GoRoute(
          path: RoutePaths.post,
          builder: (context, state) => const CreateItemScreen(),
        ),

        GoRoute(
          path: RoutePaths.items,
          builder: (context, state) => const ItemListScreen(),
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
          path: RoutePaths.itemDetail,
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ItemDetailScreen(itemId: id);
          },
        ),

        GoRoute(
          path: RoutePaths.editItem,
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return EditItemScreen(itemId: id);
          },
        ),

        GoRoute(
          path: '/admin',
          builder: (context, state) => const AdminDashboard(),
        ),

        GoRoute(
          path: '/admin/items',
          builder: (context, state) => AdminFilter(),
        ),

        GoRoute(
          path: '/admin/claims',
          builder: (context, state) => const AdminClaimsScreen(),
        ),

        GoRoute(
          path: '/admin/reports',
          builder: (context, state) => const ReportsScreen(),
        ),
      ],
    ),

    GoRoute(
      path: RoutePaths.filters,
      builder: (context, state) => FiltersScreen(),
    ),

    GoRoute(
      path: RoutePaths.admin,
      builder: (context, state) => AdminFilter(),
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
      path: RoutePaths.createClaim,
      builder: (context, state) {
        final itemId = state.pathParameters['itemId']!;
        return Scaffold(
          appBar: AppBar(title: const Text("Create Claim")),
          body: Center(
            child: Text("Create claim for item $itemId"),
          ),
        );
      },
    ),

    GoRoute(
      path: RoutePaths.claimDetail,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ClaimDetailScreen(claimId: id);
      },
    ),

    GoRoute(
      path: RoutePaths.reports,
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text("Reports")),
        body: const Center(
          child: Text("Reports list"),
        ),
      ),
    ),

    GoRoute(
      path: RoutePaths.createReport,
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text("Create Report")),
        body: const Center(
          child: Text("Create report form"),
        ),
      ),
    ),

    GoRoute(
      path: RoutePaths.reportDetail,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return Scaffold(
          appBar: AppBar(title: Text("Report $id")),
          body: Center(
            child: Text("Details of Report $id"),
          ),
        );
      },
    ),

    GoRoute(
      path: RoutePaths.adminClaims,
      builder: (context, state) => const AdminClaimsScreen(),
    ),

    GoRoute(
      path: RoutePaths.adminClaimDetail,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return AdminClaimDetailScreen(claimId: id);
      },
    ),

    GoRoute(
      path: RoutePaths.adminReports,
      builder: (context, state) => const AdminReportsScreen(),
    ),

    GoRoute(
      path: RoutePaths.adminItems,
      builder: (context, state) => AdminFilter(),
    ),

    GoRoute(
      path: RoutePaths.adminCategories,
      builder: (context, state) => const AdminCategoriesScreen(),
    ),
  ],
);