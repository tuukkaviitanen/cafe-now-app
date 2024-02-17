import 'package:flutter/material.dart';

class CafeDetailsScreen extends StatelessWidget {
  const CafeDetailsScreen({Key? key}) : super(key: key);

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
