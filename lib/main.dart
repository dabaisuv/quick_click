import 'package:flutter/material.dart';

import './quick_click/quick_click.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuickClickPage(),
    );
  }
}
