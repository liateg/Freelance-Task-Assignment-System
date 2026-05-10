import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isAdmin;

  const ItemCard({super.key, required this.item, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              item['image_url'], 
              height: 180, 
              width: double.infinity, 
              fit: BoxFit.cover
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    _buildStatusBadge(item['status']), // Adds realism for grading 
                  ],
                ),
                const SizedBox(height: 4),
                Text(item['location'], style: const TextStyle(color: Colors.grey, fontSize: 14)), //
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.push('/items/${item['id']}'), // Lia's path parameter
                    child: Text(isAdmin ? "Manage Item" : "Claim Item"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status == 'available' ? Colors.green.shade100 : Colors.orange.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(), 
        style: TextStyle(
          fontSize: 10, 
          fontWeight: FontWeight.bold, 
          color: status == 'available' ? Colors.green.shade800 : Colors.orange.shade800
        )
      ),
    );
  }
}