import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClaimsScreen extends StatelessWidget {
  const ClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final claims = ['1', '2', '3', '4'];

    return ListView.builder(
      itemCount: claims.length,
      itemBuilder: (context, index) {
        final id = claims[index];

        return ListTile(
          title: Text('Claim $id'),

          onTap: () {
            context.go('/claims/$id');
          },
        );
      },
    );
  }
}