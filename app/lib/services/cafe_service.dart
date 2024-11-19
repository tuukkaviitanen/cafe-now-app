import 'dart:convert';

import 'package:cafe_now_app/models/place.dart';
import 'package:http/http.dart' as http;

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
      Response responseBody = Response.fromJson(jsonDecode(response.body));
      return responseBody.elements;
    } else {
      throw Exception('Failed to fetch cafes');
    }
  }
}
