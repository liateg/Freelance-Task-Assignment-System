import 'package:flutter/material.dart';
import '../widgets/discovery_top_bar.dart';
import '../widgets/item_card.dart';
import '../../data/mock_data.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: Column(
          children: [
            const DiscoveryTopBar(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: mockItems.length,
                itemBuilder: (context, index) => ItemCard(item: mockItems[index]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1B4332),
        onPressed: () => Navigator.pushNamed(context, '/items/create'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}