import 'package:flutter/material.dart';
import 'utils/router/app_router.dart';

void main() {
  runApp(const ReClaimApp());
}

class ReClaimApp extends StatelessWidget {
  const ReClaimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}