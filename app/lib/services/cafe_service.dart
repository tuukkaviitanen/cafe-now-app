import 'package:cafe_now_app/models/place.dart';
import 'package:http/http.dart' as http;

import 'package:json_serializer/json_serializer.dart';

class CafeService {
  CafeService() {
    JsonSerializer.options = JsonSerializerOptions(types: [
      UserType<Place>(Place.new),
      UserType<PlaceGeometry>(PlaceGeometry.new),
      UserType<PlaceOpeningHours>(PlaceOpeningHours.new),
      UserType<PlacePhoto>(PlacePhoto.new),
      UserType<PlacePlusCode>(PlacePlusCode.new),
      UserType<Location>(Location.new),
      UserType<DayTime>(DayTime.new),
      UserType<PlaceOpeningHoursPeriod>(PlaceOpeningHoursPeriod.new),
      UserType<PlaceViewport>(PlaceViewport.new),
    ]);
  }

  static const serverUrl = String.fromEnvironment('API_URL',
      defaultValue: 'https://cafe-now-app.onrender.com');

  Future<List<Place>> fetchCafes(double latitude, double longitude) async {
    final response = await http.get(Uri.parse(
        '$serverUrl/nearbyCafes?latitude=$latitude&longitude=$longitude'));

    if (response.statusCode == 200) {
      List<Place> cafes =
          JsonSerializer.deserialize<List<Place>>(response.body);
      return cafes;
    } else {
      throw Exception('Failed to fetch cafes');
    }
  }
}
