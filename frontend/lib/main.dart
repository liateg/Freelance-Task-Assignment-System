import 'package:flutter/material.dart';
import 'utils/router/app_router.dart';
import 'utils/theme/app_theme.dart';

void main() {
  runApp(const ReClaimApp());
}

<<<<<<< HEAD
class ReClaimApp extends StatelessWidget {
  const ReClaimApp({super.key});

  @override
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      routerConfig: appRouter,
=======
      routerConfig: router,
      theme: AppTheme.lightTheme,
>>>>>>> bottom-nav
    );
  }
