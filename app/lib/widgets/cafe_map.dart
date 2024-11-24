import 'package:cafe_now_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class CafeMap extends StatelessWidget {
  const CafeMap({
    super.key,
    required AnimatedMapController animatedMapController,
    required this.cafeMarkers,
    required this.userMarkers,
    required this.centerMap,
  }) : _animatedMapController = animatedMapController;

  final AnimatedMapController _animatedMapController;
  final List<AnimatedMarker> cafeMarkers;
  final List<Marker> userMarkers;
  final Function centerMap;

  static const mapUrl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const defaultZoom = 15.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          MainApp.defaultBoxShadow,
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(51.5, -0.09),
                initialZoom: defaultZoom,
              ),
              mapController: _animatedMapController.mapController,
              children: [
                TileLayer(
                  urlTemplate: mapUrl,
                ),
                AnimatedMarkerLayer(
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
                      onTap: () => launchUrl(
                          Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 10,
              top: 10,
              child: FloatingActionButton(
                  child: const Icon(Icons.north_outlined),
                  onPressed: () => _animatedMapController.animatedRotateTo(0)),
            ),
            Positioned(
              right: 10,
              top: 80,
              child: FloatingActionButton(
                  child: const Icon(Icons.gps_fixed),
                  onPressed: () => centerMap()),
            ),
          ],
        ),
      ),
    );
  }
}
