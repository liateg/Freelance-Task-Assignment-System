import 'package:flutter/material.dart';

class DiscoveryTopBar extends StatelessWidget {
  const DiscoveryTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Hello, Darik!", style: TextStyle(fontSize: 14, color: Colors.grey)),
          const Text("Discover Items", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: "Search for lost treasures...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ["All Items", "Electronics", "Accessories", "Documents"].map((cat) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Chip(
                    label: Text(cat),
                    backgroundColor: cat == "All Items" ? const Color(0xFF1B4332) : Colors.white,
                    labelStyle: TextStyle(color: cat == "All Items" ? Colors.white : Colors.black),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}