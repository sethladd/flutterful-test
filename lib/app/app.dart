import 'package:flutter/material.dart';
import 'package:flutterful/features/home/home_screen.dart';

class FlutterfulApp extends StatelessWidget {
  const FlutterfulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterful',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
