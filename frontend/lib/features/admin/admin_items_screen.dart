import 'package:flutter/material.dart';
import 'package:frontend/utils/theme/app_theme.dart';
import 'package:frontend/shared/widgets/appbar.dart';

class AdminItemsScreen extends StatelessWidget {
  const AdminItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.detailScreenBackground,
      appBar: CustomAppBar(title: 'Lost Items Inventory', back: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: AppTheme.grayText,
            ),
            const SizedBox(height: 16),
            const Text(
              'Items Management',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage lost items inventory here',
              style: TextStyle(fontSize: 14, color: AppTheme.grayText),
            ),
          ],
        ),
      ),
    );
  }
}
