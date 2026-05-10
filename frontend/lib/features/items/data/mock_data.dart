import 'package:flutter/material.dart';

class CreateItemScreen extends StatelessWidget {
  const CreateItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("Post a New Item", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), // [cite: 11]
          const SizedBox(height: 20),
          _buildField("Item Title"), //
          _buildField("Location Found"), //
          _buildField("Description", maxLines: 3), //
          const SizedBox(height: 30),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Submit Post")),
        ],
      ),
    );
  }

  Widget _buildField(String label, {int maxLines = 1}) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextFormField(maxLines: maxLines, decoration: InputDecoration(labelText: label)),
  );
}