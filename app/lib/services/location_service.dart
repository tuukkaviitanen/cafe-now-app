import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}
