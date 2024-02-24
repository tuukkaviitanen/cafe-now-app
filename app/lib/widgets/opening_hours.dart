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
      cafe.opening_hours?.open_now == true
          ? 'Open'
          : cafe.opening_hours?.open_now == false
              ? 'Closed'
              : 'Unknown opening hours',
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.displayMedium!.fontSize,
        color: cafe.opening_hours?.open_now == true
            ? Colors.green
            : cafe.opening_hours?.open_now == false
                ? Colors.red
                : Colors.black,
      ),
    );
  }
}
