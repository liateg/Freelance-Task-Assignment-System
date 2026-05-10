import 'package:flutter/material.dart';

class ClaimItem extends StatelessWidget {
  final Map<String, dynamic> claim;

  const ClaimItem({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text((claim['title'] as String?) ?? 'Untitled Claim'),
      subtitle: Text((claim['description'] as String?) ?? ''),
      trailing: Text((claim['status'] as String?) ?? 'Pending'),
    );
  }
}
