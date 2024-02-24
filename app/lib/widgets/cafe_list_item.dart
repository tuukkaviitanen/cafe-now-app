import 'package:cafe_now_app/models/place.dart';
import 'package:cafe_now_app/screens/cafe_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            ? Theme.of(context).colorScheme.secondary
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
            title: Row(
              children: [
                Text(cafe.name, style: const TextStyle(fontSize: 25)),
                const SizedBox(width: 20),
                Text(
                  cafe.opening_hours?.open_now == true
                      ? 'Open'
                      : cafe.opening_hours?.open_now == false
                          ? 'Closed'
                          : 'Unknown opening hours',
                  style: TextStyle(
                    fontSize: 20,
                    color: cafe.opening_hours?.open_now == true
                        ? Colors.green
                        : cafe.opening_hours?.open_now == false
                            ? Colors.red
                            : Colors.black,
                  ),
                ),
              ],
            ),
            subtitle:
                Text(cafe.vicinity ?? '', style: const TextStyle(fontSize: 20)),
            trailing: ElevatedButton(
              onPressed: () {},
              child: const Text('Details'),
            )),
      ),
    );
  }
}
