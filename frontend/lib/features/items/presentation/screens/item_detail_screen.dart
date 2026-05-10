import 'package:flutter/material.dart';
import 'package:frontend/features/items/data/mock_data.dart';
import '../widgets/claim_submission_content.dart';

class ClaimDetailScreen extends StatelessWidget {
  final String claimId; 

  const ClaimDetailScreen({super.key, required this.claimId});

  @override
  Widget build(BuildContext context) {
    final item = mockItems.firstWhere((e) => e['id'] == claimId); //

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(item['image_url'], height: 250, fit: BoxFit.cover), //
          ),
          const SizedBox(height: 20),
          Text(item['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), //
          Text(item['location'], style: const TextStyle(color: Colors.grey)), //
          const SizedBox(height: 20),
          Text(item['description']), //
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => ClaimSubmissionContent(item: item), //
              );
            },
            child: const Text("Claim This Item"),
          ),
        ],
      ),
    );
  }
}