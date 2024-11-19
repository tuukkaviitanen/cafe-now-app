import 'package:cafe_now_app/models/place.dart';
import 'package:http/http.dart' as http;

import 'package:json_serializer/json_serializer.dart';

class CafeService {
  CafeService() {
    JsonSerializer.options = JsonSerializerOptions(types: [
      UserType<Response>(Response.new),
      UserType<Place>(Place.new),
      UserType<Tags>(Tags.new),
    ]);
  }

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
          JsonSerializer.deserialize<Response>(response.body);
      return responseBody.elements;
    } else {
      throw Exception('Failed to fetch cafes');
    }
  }
}
