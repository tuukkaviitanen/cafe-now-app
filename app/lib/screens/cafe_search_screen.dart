import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

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

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  Future<void> getLocation() async {
    if (await Permission.location.isGranted) {
      final location = await Geolocator.getCurrentPosition();
      _mapController.move(
          LatLng(location.latitude, location.longitude), defaultZoom);
    } else {
      await Permission.location.request();
      getLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(51.5, -0.09),
                    initialZoom: defaultZoom,
                  ),
                  mapController: _mapController,
                  children: [
                    TileLayer(
                      urlTemplate: mapUrl,
                    ),
                  ],
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
      ),
    );
  }
}
