import 'package:flutter/material.dart';

class AdminClaimDetailScreen extends StatelessWidget {
  final String claimId;

  const AdminClaimDetailScreen({super.key, required this.claimId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Claim $claimId')),
      body: Center(child: Text('Admin details for claim $claimId')),
    );
  }
}
