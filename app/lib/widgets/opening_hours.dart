import 'package:cafe_now_app/models/place.dart';
import 'package:flutter/material.dart';

class OpeningHours extends StatelessWidget {
  const OpeningHours({
    super.key,
    required this.cafe,
  });

  final Place cafe;

  @override
  Widget build(BuildContext context) {
    return Text(
      cafe.tags.openingHours ?? 'Opening hours unknown',
    );
  }
}
