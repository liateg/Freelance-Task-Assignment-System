import 'package:flutter/material.dart';
import 'package:frontend/utils/theme/app_theme.dart';

class AppNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onDestinationSelected;
  final bool adminMode;

  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    this.adminMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: AppTheme.white,
        indicatorColor: AppTheme.primaryGreen,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: adminMode
            ? [
                _buildDestination(0, Icons.grid_view_outlined, Icons.grid_view_outlined, 'DASHBOARD'),
                _buildDestination(1, Icons.inventory_2_outlined, Icons.inventory_2_outlined, 'ITEMS'),
                _buildDestination(2, Icons.receipt_long_outlined, Icons.receipt_long_outlined, 'CLAIMS'),
                _buildDestination(3, Icons.insert_chart_outlined, Icons.insert_chart_outlined, 'REPORTS'),
              ]
            : [
                _buildDestination(0, Icons.home_outlined, Icons.home_outlined, 'Home'),
                _buildDestination(1, Icons.add_circle_outline, Icons.add_circle_outline, 'POST'),
                _buildDestination(2, Icons.indeterminate_check_box_outlined, Icons.indeterminate_check_box_outlined, 'My Items'),
                _buildDestination(3, Icons.track_changes_outlined, Icons.track_changes_outlined, 'CLAIMS'),
              ],
      ),
    );
  }

  NavigationDestination _buildDestination(
    int index,
    IconData unselectedIcon,
    IconData selectedIcon,
    String label,
  ) {
    return NavigationDestination(
      icon: Icon(
        unselectedIcon,
        color: currentIndex == index ? AppTheme.white : AppTheme.grayText,
      ),
      selectedIcon: Icon(unselectedIcon, color: AppTheme.white),
      label: label,
    );
  }
}
