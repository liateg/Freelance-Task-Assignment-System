import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryChip({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),

      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: isSelected ? Colors.green : Colors.white,

        borderRadius: BorderRadius.circular(30),

        border: Border.all(
          color: isSelected
              ? Colors.green
              : Colors.grey.shade300,
        ),
      ),

      child: Text(
        label,

        style: TextStyle(
          color: isSelected
              ? Colors.white
              : Colors.black87,

          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}