import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/router/route_paths.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onProfileTap;
  final bool back;
  final bool showProfileAction;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onProfileTap,
    this.back = true,
    this.showProfileAction = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      leading: leading,
      actions: showProfileAction
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onProfileTap ??
                        () => context.push(RoutePaths.profile),
                    child: const CircleAvatar(
                      backgroundColor: Color(0xFFD6D6D6),
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ]
          : null,
      automaticallyImplyLeading: leading == null && back,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
