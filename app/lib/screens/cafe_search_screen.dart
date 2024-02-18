import 'dart:collection';

import 'package:cafe_now_app/models/place.dart';
import 'package:cafe_now_app/services/cafe_service.dart';
import 'package:cafe_now_app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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

  final LinkedHashMap<String, Marker> cafeMarkers = LinkedHashMap();
  final List<Marker> userMarkers = <Marker>[];

  Marker buildCafePin(LatLng point, Place cafe) => Marker(
        point: point,
        width: 60,
        height: 60,
        child: GestureDetector(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(cafe.name),
              duration: const Duration(seconds: 2),
              showCloseIcon: true,
            ),
          ),
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
  }

  Future<void> getLocation() async {
    final location = await _locationService.getLocation();

    userMarkers.clear();
    userMarkers
        .add(buildUserPin(LatLng(location.latitude, location.longitude)));

    setState(() {
      userMarkers;
    });

    _mapController.move(
        LatLng(location.latitude, location.longitude), defaultZoom);

    final cafes = await _cafeService.fetchCafes(
        location.latitude, location.longitude, 3000);

    for (var cafe in cafes) {
      final lat = cafe.geometry.location.lat;
      final lng = cafe.geometry.location.lng;
      cafeMarkers[cafe.place_id] = buildCafePin(LatLng(lat, lng), cafe);
    }
    setState(() {
      cafeMarkers;
    });
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
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: ElevatedButton(
                    onPressed: getLocation,
                    child: const Text('Search'),
                  ),
                ),
              ),
            ),
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
