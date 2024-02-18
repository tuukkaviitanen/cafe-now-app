import 'package:cafe_now_app/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<List<Place>> fetchCafes() async {
    final response = await http.get(Uri.parse(
        'http://localhost:8080/nearbyCafes?latitude=61.49911&longitude=23.78712&radius=3000'));

    if (response.statusCode == 200) {
      List<Place> cafes =
          JsonSerializer.deserialize<List<Place>>(response.body);
      return cafes;
    } else {
      throw Exception('Failed to fetch cafes');
    }
  }
}
