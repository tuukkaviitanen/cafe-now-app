import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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
  final List<Marker> cafeMarkers;
  final List<Marker> userMarkers;

  static const mapUrl = 'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png';
  static const defaultZoom = 15.0;

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
