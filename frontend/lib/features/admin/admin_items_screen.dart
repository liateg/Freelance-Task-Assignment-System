import 'package:flutter/material.dart';
import 'package:frontend/utils/theme/app_theme.dart';

class AdminItemsScreen extends StatelessWidget {
  const AdminItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.detailScreenBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0,
        title: const Text(
          'Lost Items Inventory',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
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
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.grayText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
