import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const mapUrl = 'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png';

class CafeSearchScreen extends StatelessWidget {
  const CafeSearchScreen({super.key});
  static const String route = '/';

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
                    initialZoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: mapUrl,
                      userAgentPackageName: 'com.example.app',
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
