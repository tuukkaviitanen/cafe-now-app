import 'package:cafe_now_app/models/place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class CafeDetailsScreen extends StatelessWidget {
  const CafeDetailsScreen({super.key, required this.cafe});
  static const String route = 'details';

  final Place cafe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(cafe.tags.name),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Hero(
                  tag: cafe.id,
                  child: Image.asset(
                      'assets/images/CuteCoffeeMugNoBackground.png')),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(cafe.tags.name,
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.displayLarge),
                            const SizedBox(height: 30), // Separator
                            (cafe.tags.phone != null)
                                ? ElevatedButton(
                                    onPressed: () => launchUrl(Uri(
                                        scheme: 'tel', path: cafe.tags.phone)),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      cafe.tags.phone!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ))
                                : const Text("No phone number"),
                            const SizedBox(height: 10), // Separator
                            Text(cafe.tags.website ?? 'No website',
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                            const SizedBox(height: 10), // Separator
                            Text(
                                textAlign: TextAlign.center,
                                cafe.tags.openingHours ??
                                    'Unknown opening hours',
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            MapsLauncher.launchQuery(cafe.tags.name);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              textAlign: TextAlign.center,
                              'Open in Maps',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
