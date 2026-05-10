import 'package:flutter/material.dart';
import '../../../items/presentation/widgets/item_card.dart';
import '../../../items/data/mock_data.dart';

class AdminItemListScreen extends StatelessWidget {
  const AdminItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin: All Posted Items"),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1B4332),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: mockItems.length,
        itemBuilder: (context, index) => ItemCard(item: mockItems[index], isAdmin: true),
      ),
    );
  }
}