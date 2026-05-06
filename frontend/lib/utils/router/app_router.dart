import 'package:go_router/go_router.dart';
import '../features/...'; // import your screens
import 'route_paths.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.login,

  routes: [

    /// AUTH
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => LoginScreen(),
    ),

    GoRoute(
      path: RoutePaths.register,
      builder: (context, state) => RegisterScreen(),
    ),

    /// ITEMS
    GoRoute(
      path: RoutePaths.items,
      builder: (context, state) => ItemListScreen(),
    ),

    GoRoute(
      path: RoutePaths.itemDetail,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ItemDetailScreen(itemId: id);
      },
    ),

    GoRoute(
      path: RoutePaths.createItem,
      builder: (context, state) => CreateItemScreen(),
    ),

    GoRoute(
      path: RoutePaths.editItem,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return EditItemScreen(itemId: id);
      },
    ),

    /// CLAIMS
    GoRoute(
      path: RoutePaths.claims,
      builder: (context, state) => MyClaimsScreen(),
    ),

    GoRoute(
      path: RoutePaths.createClaim,
      builder: (context, state) {
        final itemId = state.pathParameters['itemId']!;
        return ClaimFormScreen(itemId: itemId);
      },
    ),

    GoRoute(
      path: RoutePaths.claimDetail,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ClaimDetailScreen(claimId: id);
      },
    ),

    /// REPORTS
    GoRoute(
      path: RoutePaths.reports,
      builder: (context, state) => MyReportsScreen(),
    ),

    GoRoute(
      path: RoutePaths.createReport,
      builder: (context, state) => CreateReportScreen(),
    ),

    GoRoute(
      path: RoutePaths.reportDetail,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ReportDetailScreen(reportId: id);
      },
    ),

    /// ADMIN
    GoRoute(
      path: RoutePaths.adminClaims,
      builder: (context, state) => AdminClaimsScreen(),
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
      builder: (context, state) => AdminReportsScreen(),
    ),

    GoRoute(
      path: RoutePaths.adminItems,
      builder: (context, state) => AdminItemsScreen(),
    ),

    GoRoute(
      path: RoutePaths.adminCategories,
      builder: (context, state) => AdminCategoriesScreen(),
    ),
  ],
);