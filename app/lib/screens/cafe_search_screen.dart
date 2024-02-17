import 'package:flutter/material.dart';

class CafeSearchScreen extends StatelessWidget {
  const CafeSearchScreen({super.key});
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello Search Screen!'),
        ),
      ),
    );
  }
}
