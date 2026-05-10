import 'package:flutter/material.dart';
import 'package:frontend/utils/theme/app_theme.dart';
import 'package:frontend/shared/widgets/appbar.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.detailScreenBackground,
      appBar: CustomAppBar(
        title: 'Reports',
        back: false,
      ),
      body: Center(
        child: Text(
          'Reports',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
