import 'package:cafe_now_app/models/place.dart';
import 'package:cafe_now_app/widgets/opening_hours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maps_launcher/maps_launcher.dart';

class CafeDetailsScreen extends StatelessWidget {
  const CafeDetailsScreen({super.key, required this.cafe});
  static const String route = 'details';

  final Place cafe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(cafe.name),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Hero(
                    tag: cafe.place_id,
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
                              Text(cafe.name,
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.displayLarge),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${cafe.rating} / 5',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  const Icon(Icons.star, color: Colors.amber),
                                  Text('(${cafe.user_ratings_total})'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                  textAlign: TextAlign.center,
                                  cafe.vicinity ?? cafe.formatted_address ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                              const SizedBox(height: 10),
                              OpeningHours(cafe: cafe),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              MapsLauncher.launchQuery(cafe.name);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
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
          ),
        ));
  }
}
