import 'package:flutter/material.dart';
import 'package:frontend/utils/theme/app_theme.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Admin Dashboard',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
