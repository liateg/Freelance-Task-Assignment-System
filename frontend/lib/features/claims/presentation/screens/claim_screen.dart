import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './claim_empty.dart';

class ClaimsScreen extends StatelessWidget {
  const ClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final claims = ['1', '2', '3', '4', '5'];

    return ListView.builder(
      itemCount: claims.length,
      itemBuilder: (context, index) {
        final id = claims[index];
        if (id == '5') {
          return ListTile(
            title: const Text('Empty Claims'),
            onTap: () {
              context.go('/claims/empty');
            },
          );
        } else {
          return ListTile(
            title: Text('Claim $id'),
            onTap: () {
              context.go('/claims/$id');
            },
          );
        }
      },
    );
    
  }
}