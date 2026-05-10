import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile', back: false),
      body: const Center(child: Text('Profile')),
    );
  }
}
