import 'package:cafe_now_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class CafeMap extends StatelessWidget {
  const CafeMap({
    super.key,
    required MapController mapController,
    required this.cafeMarkers,
    required this.userMarkers,
  }) : _mapController = mapController;

  final MapController _mapController;
  final List<AnimatedMarker> cafeMarkers;
  final List<Marker> userMarkers;

  static const mapUrl = 'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png';
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
                TextSourceAttribution(
                  'Google Places API',
                  onTap: () => launchUrl(Uri.parse(
                      'https://developers.google.com/maps/documentation/places/web-service/policies')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
