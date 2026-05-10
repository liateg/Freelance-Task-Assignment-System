import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminClaimsScreen extends StatelessWidget {
  const AdminClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final claims = List.generate(5, (index) => 'admin-claim-${index + 1}');

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Claims')),
      body: ListView.builder(
        itemCount: claims.length,
        itemBuilder: (context, index) {
          final claimId = claims[index];
          return ListTile(
            title: Text('Claim ${index + 1}'),
            subtitle: Text(claimId),
            onTap: () => context.go('/admin/claims/$claimId'),
          );
        },
      ),
    );
  }
}
