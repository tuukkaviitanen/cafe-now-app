import 'package:cafe_now_app/main.dart';
import 'package:cafe_now_app/models/place.dart';
import 'package:cafe_now_app/screens/cafe_details_screen.dart';
import 'package:cafe_now_app/screens/cafe_search_screen.dart';
import 'package:cafe_now_app/widgets/opening_hours.dart';
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
      duration: MainApp.defaultAnimationDuration,
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cafe.name,
                    style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(width: 20),
                OpeningHours(cafe: cafe),
              ],
            ),
            subtitle: Text(cafe.vicinity ?? cafe.formatted_address ?? '',
                style: Theme.of(context).textTheme.displayMedium),
            trailing: ElevatedButton(
              onPressed: () {
                context.go(
                    '${CafeSearchScreen.route}${CafeDetailsScreen.route}',
                    extra: cafe);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Details',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
            )),
      ),
    );
  }
}
