import 'package:flutter/material.dart';

class EditItemScreen extends StatelessWidget {
  final String itemId;

  const EditItemScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Item $itemId')),
      body: Center(child: Text('Edit item form for $itemId')),
    );
  }
}
