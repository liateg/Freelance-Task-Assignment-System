import 'package:flutter/material.dart';
import './claim_empty.dart';
import '../widgets/claim_card.dart';
import '../../data/mock/mock_claims.dart';

class ClaimsScreen extends StatelessWidget {
  const ClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (mockClaims.isEmpty) {
      return const ClaimEmptyScreen();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: mockClaims.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
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
        return ClaimCard(claim: claimMap);
      },
    );
  }
}
