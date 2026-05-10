import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        back: false,
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}