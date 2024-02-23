import 'package:cafe_now_app/models/place.dart';
import 'package:flutter/material.dart';

class CafeListItem extends StatelessWidget {
  const CafeListItem({
    super.key,
    required this.selectedCafe,
    required this.cafe,
  });

  final Place? selectedCafe;
  final Place cafe;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(1, 2),
          ),
        ],
        color: selectedCafe?.place_id == cafe.place_id
            ? Theme.of(context).colorScheme.primary
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(cafe.name, style: const TextStyle(fontSize: 25)),
      ),
    );
  }
}
