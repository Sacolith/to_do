import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_)=> TaskProvider(),
    child: const MaterialApp(
      home: HomeScreen(),
    ),
    );
  }
}
