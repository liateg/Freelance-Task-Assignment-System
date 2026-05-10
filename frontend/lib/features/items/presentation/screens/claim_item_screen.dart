import 'package:flutter/material.dart';
import 'package:frontend/features/items/data/mock_data.dart';
import 'package:frontend/features/items/presentation/widgets/item_card.dart';
import 'package:frontend/features/items/presentation/widgets/discovery_top_bar.dart';
import 'package:frontend/shared/widgets/navigation/appbar.dart';

class ClaimsScreen extends StatelessWidget {
  const ClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Discover Items",
        back: false, // No back button on home
        onProfileTap: () => print("Profile Tapped"),
      ),
      body: Column(
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
    );
  }
}