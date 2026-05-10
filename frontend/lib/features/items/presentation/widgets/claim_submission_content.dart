import 'package:flutter/material.dart';

class ClaimSubmissionContent extends StatelessWidget {
  final Map<String, dynamic> item;
  const ClaimSubmissionContent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Claim Management", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), //
          const SizedBox(height: 20),
          _infoBox(theme, item),
          const SizedBox(height: 20),
          Text("Evidence: ${item['verification_question']}"), // [cite: 11]
          const TextField(decoration: InputDecoration(hintText: "Your answer...")),
          const Spacer(),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Submit Claim")),
        ],
      ),
    );
  }

  Widget _infoBox(ThemeData theme, Map item) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: theme.primaryColor, borderRadius: BorderRadius.circular(15)),
    child: Column(children: [
      _row(Icons.location_on, item['location']), //
      const Divider(color: Colors.white24),
      _row(Icons.calendar_today, item['date_found']), //
    ]),
  );

  Widget _row(IconData icon, String val) => Row(children: [
    Icon(icon, color: Colors.white, size: 18),
    const SizedBox(width: 10),
    Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  ]);
}