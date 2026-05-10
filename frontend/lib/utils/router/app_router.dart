import 'package:go_router/go_router.dart';

import '../../features/items/categories/filters.dart';
import '../../features/items/admin/adminfilter.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/items',

  routes: [
    GoRoute(
      path: '/items',
      builder: (context, state) => Home(),
    ),

    GoRoute(
      path: '/admin',
      builder: (context, state) => AdminFilter(),
    ),
  ],
);