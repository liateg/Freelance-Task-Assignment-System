import 'package:flutter/material.dart';

class DiscoveryTopBar extends StatelessWidget {
  const DiscoveryTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Discover Items", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)), //
          const SizedBox(height: 15),
          const TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search...")),
        ],
      ),
    );
  }
}