import 'package:flutter/material.dart';
import 'package:frontend/utils/theme/app_theme.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Reports',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
