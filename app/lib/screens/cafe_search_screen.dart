import 'dart:collection';

import 'package:cafe_now_app/models/place.dart';
import 'package:cafe_now_app/services/cafe_service.dart';
import 'package:cafe_now_app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

const mapUrl = 'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png';
const defaultZoom = 15.0;

class CafeSearchScreen extends StatefulWidget {
  const CafeSearchScreen({super.key});
  static const String route = '/';

  @override
  State<CafeSearchScreen> createState() => _CafeSearchScreenState();
}

class _CafeSearchScreenState extends State<CafeSearchScreen> {
  late MapController _mapController;
  late LocationService _locationService;
  late CafeService _cafeService;
  late ItemScrollController _itemScrollController;

  final LinkedHashMap<String, Marker> cafeMarkers = LinkedHashMap();
  final List<Marker> userMarkers = <Marker>[];

  final LinkedHashMap<String, Place> cafes = LinkedHashMap();

  Place? selectedCafe;

  void selectCafe(Place cafe) {
    _mapController.move(
        LatLng(cafe.geometry.location.lat, cafe.geometry.location.lng),
        defaultZoom + 2);
    _itemScrollController.scrollTo(
      index: cafes.keys.toList().indexOf(cafe.place_id),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutCubic,
    );
    setState(() {
      selectedCafe = cafe;
    });
  }

  Marker buildCafePin(LatLng point, Place cafe) => Marker(
        point: point,
        width: 60,
        height: 60,
        child: GestureDetector(
          onTap: () => selectCafe(cafe),
          child: Image.asset("assets/images/CuteCoffeeMugNoBackground.png"),
        ),
      );

  Marker buildUserPin(LatLng point) => Marker(
        point: point,
        width: 60,
        height: 60,
        child: const Icon(
          Icons.room,
          color: Colors.blue,
          size: 60,
        ),
      );

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _locationService = LocationService();
    _cafeService = CafeService();
    _itemScrollController = ItemScrollController();

    populateMap().catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred: ${error.toString()}'),
          duration: const Duration(seconds: 2),
          showCloseIcon: true,
        ),
      );
    });
  }

  Future<void> setUserOnMap(Position location) async {
    userMarkers.clear();
    userMarkers
        .add(buildUserPin(LatLng(location.latitude, location.longitude)));

    setState(() {
      userMarkers;
    });

    _mapController.move(
        LatLng(location.latitude, location.longitude), defaultZoom);
  }

  Future<void> setCafesOnMap(List<Place> cafes) async {
    for (var cafe in cafes) {
      final lat = cafe.geometry.location.lat;
      final lng = cafe.geometry.location.lng;
      cafeMarkers[cafe.place_id] = buildCafePin(LatLng(lat, lng), cafe);
      this.cafes[cafe.place_id] = cafe;
    }
    setState(() {
      cafeMarkers;
      this.cafes;
    });
  }

  Future<void> populateMap() async {
    final location = await _locationService.getLocation();

    await setUserOnMap(location);

    final cafes = await _cafeService.fetchCafes(
        location.latitude, location.longitude, 3000);

    await setCafesOnMap(cafes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: CafeMap(
                mapController: _mapController,
                cafeMarkers: cafeMarkers.values.toList(),
                userMarkers: userMarkers,
              ),
            ),
            Expanded(
              flex: 1,
              child: ScrollablePositionedList.separated(
                itemScrollController: _itemScrollController,
                itemCount: cafes.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final cafe = cafes.values.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
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
                      child: GestureDetector(
                        onTap: () => selectCafe(cafe),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(cafe.name,
                              style: const TextStyle(fontSize: 25)),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 0,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CafeMap extends StatelessWidget {
  const CafeMap({
    super.key,
    required MapController mapController,
    required this.cafeMarkers,
    required this.userMarkers,
  }) : _mapController = mapController;

  final MapController _mapController;
  final List<Marker> cafeMarkers;
  final List<Marker> userMarkers;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(51.5, -0.09),
        initialZoom: defaultZoom,
      ),
      mapController: _mapController,
      children: [
        TileLayer(
          urlTemplate: mapUrl,
        ),
        MarkerLayer(
          markers: cafeMarkers,
          rotate: true,
        ),
        MarkerLayer(
          markers: userMarkers,
          rotate: true,
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
    );
  }
}
