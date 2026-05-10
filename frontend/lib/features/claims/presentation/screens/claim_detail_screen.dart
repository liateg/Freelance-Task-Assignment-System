import 'package:flutter/material.dart';

class ClaimDetailScreen extends StatelessWidget {
  final String claimId;

  const ClaimDetailScreen({
    super.key,
    required this.claimId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Claim $claimId'),
      ),

      body: Center(
        child: Text('Details of Claim $claimId'),
      ),
    );
  }
}