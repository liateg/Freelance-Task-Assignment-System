import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/shared/widgets/appbar.dart';
import 'package:frontend/utils/theme/app_theme.dart';
import './claim_empty.dart';
import '../widgets/claim_card.dart';
import '../../data/mock/mock_claims.dart';
import 'claim_withdraw.dart';
import 'claim_delete.dart';

class ClaimsScreen extends StatelessWidget {
  const ClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (mockClaims.isEmpty) {
      return const ClaimEmptyScreen();
    }

    return Scaffold(
      backgroundColor: AppTheme.detailScreenBackground,
      appBar: CustomAppBar(title: 'My Claims', back: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// DEV BUTTON - SWITCH TO ADMIN MODE
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => context.go('/admin/claims'),
                  icon: const Icon(Icons.admin_panel_settings, size: 16),
                  label: const Text('Admin', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Text(
              'Track the status of your lost and found claims here.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: mockClaims.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final claimObj = mockClaims[index];

                final claimMap = {
                  'id': claimObj.id,
                  'title': claimObj.title,
                  'description': claimObj.description,
                  'date': claimObj.date.toString().split(' ')[0],
                  'status': claimObj.status
                      .toString()
                      .split('.')
                      .last
                      .toUpperCase(),
                  'imageUrl': claimObj.imageUrl ?? '',
                  'filedDate': claimObj.date.toString().split(' ')[0],
                };
                final status = claimMap['status'] ?? 'PENDING';
                final isPending = status == 'PENDING';

                return ClaimCard(
                  claim: claimMap,
                  onWithdraw: () async {
                    // TODO: when state management is added, confirm actions should update the claims list.
                    if (isPending) {
                      await showClaimWithdrawDialog(context);
                    } else {
                      await showClaimDeleteDialog(context);
                    }
                  },
                  onTap: () => context.go('/claims/${claimObj.id}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
