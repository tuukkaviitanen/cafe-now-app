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
          MainApp.defaultBoxShadow,
        ],
        color: selectedCafe?.id == cafe.id
            ? Theme.of(context).colorScheme.secondary
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cafe.tags.name,
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 8),
                  OpeningHours(cafe: cafe),
                  const SizedBox(height: 4),
                  Text(cafe.tags.getAddress() ?? 'Address unknown',
                      style: Theme.of(context).textTheme.displaySmall)
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.go(
                    '${CafeSearchScreen.route}${CafeDetailsScreen.route}',
                    extra: cafe);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text('Details',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
            )
          ],
        ),
      ),
    );
  }
}
