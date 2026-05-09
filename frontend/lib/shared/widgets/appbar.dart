import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onProfileTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: onProfileTap,
            child: const CircleAvatar(
              backgroundColor: const Color(0xFFD6D6D6),
              child: Icon(Icons.person, color: Colors.black),
              ),
            ),
          ),

      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}