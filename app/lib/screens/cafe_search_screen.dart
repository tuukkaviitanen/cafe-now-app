import 'dart:collection';

import 'package:cafe_now_app/models/place.dart';
import 'package:cafe_now_app/services/cafe_service.dart';
import 'package:cafe_now_app/services/location_service.dart';
import 'package:cafe_now_app/widgets/cafe_list_item.dart';
import 'package:cafe_now_app/widgets/cafe_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
        CafeMap.defaultZoom + 2);
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
        LatLng(location.latitude, location.longitude), CafeMap.defaultZoom);
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
      appBar: AppBar(
        title: const Text('Cafe Now!'),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
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
              child: ScrollablePositionedList.builder(
                itemScrollController: _itemScrollController,
                itemCount: cafes.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final cafe = cafes.values.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => selectCafe(cafe),
                      child:
                          CafeListItem(selectedCafe: selectedCafe, cafe: cafe),
                    ),
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
