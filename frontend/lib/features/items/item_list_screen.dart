import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(8, (index) => 'item-${index + 1}');

    return Scaffold(
      appBar: AppBar(title: const Text('My Items')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final itemId = items[index];
          return ListTile(
            title: Text('Item ${index + 1}'),
            subtitle: Text('ID: $itemId'),
            onTap: () => context.go('/items/$itemId'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/post'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
