import 'package:frontend/features/auth/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'route_paths.dart';
import "../../features/auth/presentation/screens/splash_screen.dart";
import "../../features/auth/presentation/screens/signin_screen.dart";
import "../../features/auth/presentation/screens/signup_screen.dart";
final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.splash,

  routes: [
    GoRoute(path: RoutePaths.splash,
    builder: (context,state)=> const SplashScreen(),
    ),
    /// AUTH
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => SignInScreen(role: 'user'),
    ),

    GoRoute(
      path: RoutePaths.adminLogin,  // Add this if needed
      builder: (context, state) => const SignInScreen(role: 'admin'),
    ),
    GoRoute(
      path: RoutePaths.register,
      builder: (context, state) => SignUpScreen(),
    ),

    /// ITEMS
    // GoRoute(
    //   path: RoutePaths.items,
    //   builder: (context, state) => ItemListScreen(),
    // ),

    // GoRoute(
    //   path: RoutePaths.itemDetail,
    //   builder: (context, state) {
    //     final id = state.pathParameters['id']!;
    //     return ItemDetailScreen(itemId: id);
    //   },
    // ),
    //
    // GoRoute(
    //   path: RoutePaths.createItem,
    //   builder: (context, state) => CreateItemScreen(),
    // ),
    //
    // GoRoute(
    //   path: RoutePaths.editItem,
    //   builder: (context, state) {
    //     final id = state.pathParameters['id']!;
    //     return EditItemScreen(itemId: id);
    //   },
    // ),
    //
    // /// CLAIMS
    // GoRoute(
    //   path: RoutePaths.claims,
    //   builder: (context, state) => MyClaimsScreen(),
    // ),
    //
    // GoRoute(
    //   path: RoutePaths.createClaim,
    //   builder: (context, state) {
    //     final itemId = state.pathParameters['itemId']!;
    //     return ClaimFormScreen(itemId: itemId);
    //   },
    // ),
    //
    // GoRoute(
    //   path: RoutePaths.claimDetail,
    //   builder: (context, state) {
    //     final id = state.pathParameters['id']!;
    //     return ClaimDetailScreen(claimId: id);
    //   },
    // ),
    //
    // /// REPORTS
    // GoRoute(
    //   path: RoutePaths.reports,
    //   builder: (context, state) => MyReportsScreen(),
    // ),
    //
    // GoRoute(
    //   path: RoutePaths.createReport,
    //   builder: (context, state) => CreateReportScreen(),
    // ),
    //
    // GoRoute(
    //   path: RoutePaths.reportDetail,
    //   builder: (context, state) {
    //     final id = state.pathParameters['id']!;
    //     return ReportDetailScreen(reportId: id);
    //   },
    // ),
    //
    // /// ADMIN
    // GoRoute(
    //   path: RoutePaths.adminClaims,
    //   builder: (context, state) => AdminClaimsScreen(),
    // ),
    //
    // GoRoute(
    //   path: RoutePaths.adminClaimDetail,
    //   builder: (context, state) {
    //     final id = state.pathParameters['id']!;
    //     return AdminClaimDetailScreen(claimId: id);
    //   },
    // ),
    //
    // GoRoute(
    //   path: RoutePaths.adminReports,
    //   builder: (context, state) => AdminReportsScreen(),
    // ),
    //
    // GoRoute(
    //   path: RoutePaths.adminItems,
    //   builder: (context, state) => AdminItemsScreen(),
    // ),
    //
    // GoRoute(
    //   path: RoutePaths.adminCategories,
    //   builder: (context, state) => AdminCategoriesScreen(),
    // ),
  ],
);