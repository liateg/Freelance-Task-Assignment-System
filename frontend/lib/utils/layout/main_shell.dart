import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/session/app_session.dart';
import '../../shared/widgets/navigation/app_bottom_nav.dart';
import '../router/route_paths.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  int _getIndex(String location, bool isAdmin) {
    if (isAdmin) {
      if (location.startsWith(RoutePaths.adminItems)) return 1;
      if (location.startsWith(RoutePaths.adminClaims)) return 2;
      if (location.startsWith(RoutePaths.adminReports)) return 3;
      if (location.startsWith(RoutePaths.adminDashboard)) return 0;
      if (location.startsWith(RoutePaths.profile)) return 0;
      return 0;
    }

    if (location.startsWith(RoutePaths.profile) ||
        location.startsWith(RoutePaths.reports)) {
      return 0;
    }

    if (location.startsWith(RoutePaths.home)) return 0;
    if (location.startsWith(RoutePaths.post)) return 1;
    if (location.startsWith(RoutePaths.items)) return 2;
    if (location.startsWith(RoutePaths.claims)) return 3;
    return 0;
  }

  String _userPath(int index) {
    switch (index) {
      case 0:
        return RoutePaths.home;
      case 1:
        return RoutePaths.post;
      case 2:
        return RoutePaths.items;
      case 3:
        return RoutePaths.claims;
      default:
        return RoutePaths.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    final isAdmin = AppSession.isAdmin;
    final currentIndex = _getIndex(location, isAdmin);

    return Scaffold(
      body: child,
      bottomNavigationBar: AppNavigationBar(
        currentIndex: currentIndex,
        adminMode: isAdmin,
        onDestinationSelected: (index) {
          if (isAdmin) {
            switch (index) {
              case 0:
                context.go(RoutePaths.adminDashboard);
                return;
              case 1:
                context.go(RoutePaths.adminItems);
                return;
              case 2:
                context.go(RoutePaths.adminClaims);
                return;
              case 3:
                context.go(RoutePaths.adminReports);
                return;
            }
          }

          context.go(_userPath(index));
        },
      ),
    );
  }
}
