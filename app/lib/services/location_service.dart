import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position> getLocation() async {
    if (await Permission.location.isGranted) {
      return Geolocator.getCurrentPosition();
    } else if (await Permission.location.isDenied) {
      throw Exception('Location permission is denied');
    } else {
      await Permission.location.request();
      return getLocation();
    }
  }
}
