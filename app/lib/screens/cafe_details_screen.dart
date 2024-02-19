import 'package:flutter/material.dart';

class CafeDetailsScreen extends StatelessWidget {
  const CafeDetailsScreen({super.key});
  static const String route = 'details/:id';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello Details Screen!'),
        ),
      ),
    );
  }
}
