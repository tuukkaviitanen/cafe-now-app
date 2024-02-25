import 'dart:collection';

import 'package:cafe_now_app/main.dart';
import 'package:cafe_now_app/models/place.dart';
import 'package:cafe_now_app/services/cafe_service.dart';
import 'package:cafe_now_app/services/location_service.dart';
import 'package:cafe_now_app/widgets/cafe_list_item.dart';
import 'package:cafe_now_app/widgets/cafe_loading_screen.dart';
import 'package:cafe_now_app/widgets/cafe_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CafeSearchScreen extends StatefulWidget {
  const CafeSearchScreen({super.key});
  static const String route = '/';

  @override
  State<CafeSearchScreen> createState() => _CafeSearchScreenState();
}

class _CafeSearchScreenState extends State<CafeSearchScreen>
    with TickerProviderStateMixin {
  late AnimatedMapController _animatedMapController;
  late LocationService _locationService;
  late CafeService _cafeService;
  late ItemScrollController _itemScrollController;

  final LinkedHashMap<String, AnimatedMarker> cafeMarkers = LinkedHashMap();
  final List<Marker> userMarkers = <Marker>[];

  final LinkedHashMap<String, Place> cafes = LinkedHashMap();

  Place? selectedCafe;

  String? loadingMessage;

  String? error;

  void selectCafe(Place cafe, {double additionalZoom = 0}) {
    _animatedMapController.animateTo(
        dest: LatLng(cafe.geometry.location.lat, cafe.geometry.location.lng),
        zoom: CafeMap.defaultZoom + 2 + additionalZoom);
    _itemScrollController.scrollTo(
      index: cafes.keys.toList().indexOf(cafe.place_id),
      duration: MainApp.defaultAnimationDuration,
      curve: Curves.easeInOutCubic,
    );
    setState(() {
      selectedCafe = cafe;
    });
  }

  AnimatedMarker buildAnimatedCafePin(LatLng point, Place cafe) =>
      AnimatedMarker(
        duration: MainApp.defaultAnimationDuration,
        curve: Curves.easeInOut,
        point: point,
        width: 120,
        height: 120,
        builder: (BuildContext context, Animation<double> animation) {
          const defaultPinSize = 60.0;
          final size = cafe.place_id == selectedCafe?.place_id
              ? defaultPinSize + (animation.value * defaultPinSize)
              : defaultPinSize;
          return GestureDetector(
            onTap: () => selectCafe(cafe),
            onDoubleTap: () => selectCafe(cafe, additionalZoom: 2),
            child: Hero(
              tag: cafe.place_id,
              child: Image.asset(
                "assets/images/CuteCoffeeMugNoBackground.png",
                width: size,
                height: size,
              ),
            ),
          );
        },
      );

  Marker buildUserPin(LatLng point) => Marker(
        point: point,
        width: 60,
        height: 60,
        alignment: Alignment.topCenter,
        child: const Icon(
          Icons.room,
          color: Colors.blue,
          size: 60,
        ),
      );

  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(
        vsync: this,
        duration: MainApp.defaultAnimationDuration,
        curve: Curves.easeInOut);
    _locationService = LocationService();
    _cafeService = CafeService();
    _itemScrollController = ItemScrollController();

    populateMap();
  }

  Future<void> setUserOnMap(Position location) async {
    userMarkers.clear();
    userMarkers
        .add(buildUserPin(LatLng(location.latitude, location.longitude)));

    setState(() {
      userMarkers;
    });

    await _animatedMapController.animateTo(
        dest: LatLng(location.latitude, location.longitude),
        zoom: CafeMap.defaultZoom);
  }

  Future<void> setCafesOnMap(List<Place> cafes) async {
    for (var cafe in cafes) {
      final lat = cafe.geometry.location.lat;
      final lng = cafe.geometry.location.lng;
      cafeMarkers[cafe.place_id] = buildAnimatedCafePin(LatLng(lat, lng), cafe);
      this.cafes[cafe.place_id] = cafe;
    }
    setState(() {
      cafeMarkers;
      this.cafes;
    });
  }

  Future<void> populateMap() async {
    try {
      setState(() {
        loadingMessage = 'Acquiring location...';
      });

      final location = await _locationService.getLocation();

      await setUserOnMap(location);

      setState(() {
        loadingMessage = 'Fetching cafes...';
      });

      final cafes =
          await _cafeService.fetchCafes(location.latitude, location.longitude);

      await setCafesOnMap(cafes);
    } catch (error) {
      setState(() {
        this.error = error.toString();
      });
    } finally {
      setState(() {
        loadingMessage = null;
      });
    }
  }

  Future<void> retryPopulateMap() async {
    setState(() {
      error = null;
    });

    await populateMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafe Now!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CafeMap(
                  mapController: _animatedMapController.mapController,
                  cafeMarkers: cafeMarkers.values.toList(),
                  userMarkers: userMarkers,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: (loadingMessage != null)
                  ? CafeLoadingScreen(message: loadingMessage!)
                  : (error != null)
                      ? errorDisplay(context)
                      : (cafeMarkers.isEmpty)
                          ? Image.asset(
                              'assets/images/CuteCoffeeMugNoBackground.png')
                          : cafeList(),
            ),
          ],
        ),
      ),
    );
  }

  Card errorDisplay(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Error occurred!",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 30),
            Text(
              error!,
              style: Theme.of(context).textTheme.displayMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: retryPopulateMap,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Retry',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ScrollablePositionedList cafeList() {
    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      itemCount: cafes.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final cafe = cafes.values.elementAt(index);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => selectCafe(cafe),
            child: CafeListItem(selectedCafe: selectedCafe, cafe: cafe),
          ),
        );
      },
    );
  }
}
