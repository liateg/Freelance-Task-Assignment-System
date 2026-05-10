import 'package:flutter/material.dart';
import 'package:frontend/features/items/data/mock_data.dart';
import 'package:frontend/features/items/presentation/widgets/item_card.dart';
import 'package:frontend/features/items/presentation/widgets/discovery_top_bar.dart';
import 'package:frontend/shared/widgets/appbar.dart';
import 'package:frontend/features/items/presentation/widgets/category_chip.dart';

class ClaimsScreen extends StatefulWidget {
  const ClaimsScreen({super.key});

  @override
  State<ClaimsScreen> createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredItems {
    final query = _searchController.text.trim().toLowerCase();
    return mockItems.where((item) {
      final title = (item['title'] as String?)?.toLowerCase() ?? '';
      final location = (item['location'] as String?)?.toLowerCase() ?? '';
      final category = (item['category'] as String?) ?? 'Other';
      final matchesQuery = query.isEmpty || title.contains(query) || location.contains(query);
      final matchesCategory = _selectedCategory == 'All' || category == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Discover Items',
        back: false,
      ),
      body: Column(
        children: [
          DiscoveryTopBar(
            searchController: _searchController,
            onSearchChanged: (_) => setState(() {}),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                CategoryChip(
                  label: 'All',
                  isSelected: _selectedCategory == 'All',
                  onTap: () => setState(() => _selectedCategory = 'All'),
                ),
                CategoryChip(
                  label: 'Electronics',
                  isSelected: _selectedCategory == 'Electronics',
                  onTap: () => setState(() => _selectedCategory = 'Electronics'),
                ),
                CategoryChip(
                  label: 'Accessories',
                  isSelected: _selectedCategory == 'Accessories',
                  onTap: () => setState(() => _selectedCategory = 'Accessories'),
                ),
                CategoryChip(
                  label: 'Documents',
                  isSelected: _selectedCategory == 'Documents',
                  onTap: () => setState(() => _selectedCategory = 'Documents'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.search_off, size: 60, color: Colors.grey),
                        const SizedBox(height: 12),
                        const Text('No items found'),
                        TextButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _selectedCategory = 'All');
                          },
                          child: const Text('Reset filters'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: items.length,
                    itemBuilder: (context, index) => ItemCard(item: items[index]),
                  ),
          ),
        ],
      ),
    );
  }
}