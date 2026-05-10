import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onProfileTap;
  final bool back;
  const CustomAppBar({
    super.key,
    required this.title,
    this.onProfileTap,
    this.back = true,
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
              backgroundColor: Color(0xFFD6D6D6),
              child: Icon(Icons.person, color: Colors.black),
            ),
          ),
        ),
      ],
      automaticallyImplyLeading: back,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
