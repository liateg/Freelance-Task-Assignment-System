import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/navigation/app_bottom_nav.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  int _getIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/post')) return 1;
    if (location.startsWith('/items')) return 2;
    if (location.startsWith('/claims')) return 3;
    return 0;
  }

  String _getPath(int index) {
    switch (index) {
      case 0:
        return '/home';
      case 1:
        return '/post';
      case 2:
        return '/items';
      case 3:
        return '/claims';
      default:
        return '/home';
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    final currentIndex = _getIndex(location);
    final isAdmin =
        location.startsWith('/admin') || location.startsWith('/admin/');

    return Scaffold(
      body: child,

      bottomNavigationBar: AppNavigationBar(
        currentIndex: currentIndex,
        adminMode: isAdmin,
        onDestinationSelected: (index) {
          // map admin index to admin paths, else normal paths
          if (isAdmin) {
            switch (index) {
              case 0:
                context.go('/admin');
                return;
              case 1:
                context.go('/admin/items');
                return;
              case 2:
                context.go('/admin/claims');
                return;
              case 3:
                context.go('/admin/reports');
                return;
            }
          }

          context.go(_getPath(index));
        },
      ),
    );
  }
}
