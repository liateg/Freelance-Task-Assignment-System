import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/utils/theme/app_theme.dart';
import 'package:frontend/shared/widgets/appbar.dart';
import '../widgets/admin.claim_card.dart';
import '../../data/mock/mock_claims.dart';
import 'admin.claim_confirmed_screen.dart';
import 'admin.claim_denied_dialog.dart';

class AdminClaimScreen extends StatelessWidget {
  const AdminClaimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.detailScreenBackground,
      appBar: CustomAppBar(
        title: 'Claims Inventory',
        back: false,
      ),
      body: Column(
        children: [
          // DEV BUTTONS TOOLBAR
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => context.go('/claims'),
                  icon: const Icon(Icons.person, size: 16),
                  label: const Text('User', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => showAdminClaimConfirmedDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: AppTheme.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: const Text('Show Confirmed', style: TextStyle(fontSize: 12)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => showAdminClaimDeniedDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentRed,
                    foregroundColor: AppTheme.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: const Text('Show Denied', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
          Expanded(
            child: mockClaims.isEmpty
                ? _buildEmptyState()
                : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 0.65,
                  mainAxisSpacing: 20,
                ),
                itemCount: mockClaims.length,
                itemBuilder: (context, index) {
                  final claim = mockClaims[index];
                  final dateFormatted = _formatDate(claim.date);

                  return AdminClaimCard(
                    title: claim.title,
                    location: claim.location,
                    imageUrl: claim.imageUrl ?? '',
                    date: dateFormatted,
                    onPressed: () {
                      // TODO: Navigate to claim review/detail screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Reviewing: ${claim.title}')),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Format date to display format (e.g., "YESTERDAY", "JAN 15", etc.)
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final claimDay = DateTime(date.year, date.month, date.day);

    if (claimDay == today) {
      return 'TODAY';
    } else if (claimDay == yesterday) {
      return 'YESTERDAY';
    } else {
      // Format as "MMM DD"
      return '${_monthAbbr(date.month)} ${date.day.toString().padLeft(2, '0')}';
    }
  }

  String _monthAbbr(int month) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return months[month - 1];
  }

  /// Empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: AppTheme.grayText),
          const SizedBox(height: 16),
          const Text(
            'No Claims Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Claims will appear here',
            style: TextStyle(fontSize: 14, color: AppTheme.grayText),
          ),
        ],
      ),
    );
  }
}
