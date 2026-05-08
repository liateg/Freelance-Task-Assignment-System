import 'package:flutter/material.dart';
import 'shared/widgets/custom_button.dart';
import 'shared/widgets/custom_text_field.dart';
import 'shared/widgets/app_logo.dart';
import 'utils/router/app_router.dart';
import 'package:go_router/go_router.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: appRouter,
    );
  }
}

