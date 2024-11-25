import 'package:cafe_now_app/models/place.dart';
import 'package:cafe_now_app/screens/cafe_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class CafeDetailsScreen extends StatelessWidget {
  const CafeDetailsScreen({super.key, required this.cafe});
  static const String route = 'details';

  final Place? cafe;

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    if (cafe == null) {
      context.go(CafeSearchScreen.route, extra: cafe);
      return const Scaffold();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(cafe!.tags.name),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Hero(
                  tag: cafe!.id,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    child: Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(cafe!.tags.name,
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.displayLarge),
                              const SizedBox(height: 30), // Separator
                              Text(
                                  textAlign: TextAlign.center,
                                  cafe!.tags.getAddress() ??
                                      'Address not specified',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                              const SizedBox(height: 20), // Separator
                              LinkButton(
                                text: "Open in Maps",
                                onPressed: () => MapsLauncher.launchCoordinates(
                                  cafe!.lat,
                                  cafe!.lon,
                                  cafe!.tags.name,
                                ),
                                icon: Icons.navigation,
                              ),
                              const SizedBox(height: 30), // Separator
                              Text(
                                  textAlign: TextAlign.center,
                                  cafe!.tags.openingHours ??
                                      'Opening hours unknown',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                              const SizedBox(height: 30), // Separator
                              Text(
                                  textAlign: TextAlign.center,
                                  'Find out more!',
                                  style:
                                      Theme.of(context).textTheme.displayLarge),
                              const SizedBox(height: 20), // Separator
                              (cafe!.tags.website != null)
                                  ? LinkButton(
                                      onPressed: () => launchUrl(
                                          Uri.parse(cafe!.tags.website!)),
                                      text: Uri.parse(cafe!.tags.website!).host,
                                      icon: Icons.link)
                                  : Text(
                                      textAlign: TextAlign.center,
                                      "No website available",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                              const SizedBox(height: 20), // Separator
                              (cafe!.tags.phone != null)
                                  ? LinkButton(
                                      onPressed: () => launchUrl(Uri(
                                          scheme: 'tel',
                                          path: cafe!.tags.phone)),
                                      text: cafe!.tags.phone!,
                                      icon: Icons.phone)
                                  : Text(
                                      textAlign: TextAlign.center,
                                      "No phone number available",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),

                              const SizedBox(height: 20), // Separator
                              (cafe!.tags.email != null)
                                  ? LinkButton(
                                      onPressed: () => launchUrl(Uri(
                                          scheme: 'mailto',
                                          path: cafe!.tags.email)),
                                      text: cafe!.tags.email!,
                                      icon: Icons.email,
                                    )
                                  : Text(
                                      textAlign: TextAlign.center,
                                      "No email available",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class LinkButton extends StatelessWidget {
  const LinkButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.icon});

  final void Function() onPressed;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                textAlign: TextAlign.center,
                text,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
