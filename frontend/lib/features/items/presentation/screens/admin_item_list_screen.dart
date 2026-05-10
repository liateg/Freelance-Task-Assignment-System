import 'package:flutter/material.dart';
import 'package:frontend/features/shared/widgets/navigation/appbar.dart'; 
import 'package:frontend/features/items/data/mock_data.dart';


class AdminItemListScreen extends StatelessWidget {
  const AdminItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "My Posts", back: false),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("My Posts", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
            const Text("Managing your active traces and valued returns.", style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: mockItems.length,
                itemBuilder: (context, index) => _buildAdminCard(mockItems[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminCard(Map item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(item['image_url'], width: 70, height: 70, fit: BoxFit.cover)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(item['location'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.edit_note, color: Color(0xFF1B4332)),
        ],
      ),
    );
  }
}