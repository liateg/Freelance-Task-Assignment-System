import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'My Claims',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 26),
          child: Text(
            'Track the status of your lost and found claims here.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: mockClaims.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final claimObj = mockClaims[index];

              final claimMap = {
                'id': claimObj.id,
                'title': claimObj.title,
                'description': claimObj.description,
                'date': claimObj.date.toString().split(' ')[0],
                'status': claimObj.status.toString().split('.').last.toUpperCase(),
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
    );
  }
}