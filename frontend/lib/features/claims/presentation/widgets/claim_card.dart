import 'package:flutter/material.dart';

class ClaimCard extends StatelessWidget {
  final String claimId;

  const ClaimCard({super.key, required this.claimId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Claim $claimId'),
        subtitle: const Text('Claim details go here'),
        onTap: () {
          // Handle card tap, e.g., navigate to claim details
        },
      ),
    );
  }
}