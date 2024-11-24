import 'dart:convert';
import 'package:cafe_now_app/models/place.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class CafeService {
  Future<List<Place>> fetchCafes(double latitude, double longitude) async {
    const url = "https://overpass-api.de/api/interpreter";

    final request = '''
      [out:json];
      node
        ["amenity"="cafe"]
        (around:1000, $latitude, $longitude);
      out;
    ''';

    final response = await http.post(Uri.parse(url), body: request);

    if (response.statusCode == 200) {
      Response responseBody =
          Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      const Distance distance = Distance();

      final userCoordinates = LatLng(latitude, longitude);

      final cafes = responseBody.elements;

      responseBody.elements.sort((a, b) {
        final aCoordinates = LatLng(a.lat, a.lon);
        final bCoordinates = LatLng(b.lat, b.lon);

        final aDistance =
            distance.as(LengthUnit.Meter, userCoordinates, aCoordinates);
        final bDistance =
            distance.as(LengthUnit.Meter, userCoordinates, bCoordinates);

        return aDistance.compareTo(bDistance);
      });

      return cafes;
    } else {
      throw Exception('Failed to fetch cafes');
    }
  }
}
