import 'package:flutter/material.dart';
import 'package:frontend/utils/theme/app_theme.dart';

class ClaimEmptyScreen extends StatelessWidget {
  const ClaimEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
          
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.grayBorder.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.mail_outline,
                size: 60,
                color: AppTheme.grayText,
              ),
            ),
            const SizedBox(height: 32),
           
            Text(
              'No Claims Yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
         
            Text(
              'Your digital history is a clean slate. Any items you report as lost or found will appear here for tracking.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.grayText,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
           
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                
                },
                icon: const Icon(Icons.explore),
                label: const Text('Explore Items'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: AppTheme.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
         
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'How it works',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),
         
            _buildStep(
              context,
              icon: Icons.search,
              title: 'Search the database',
              description: 'Browse thousands of recovered items updated daily',
            ),
            const SizedBox(height: 16),
            _buildStep(
              context,
              icon: Icons.add_circle_outline,
              title: 'Create a report',
              description:
                  'Lost something? Our AI matching will find a potential match',
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.grayBorder.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppTheme.grayText, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.grayText,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
