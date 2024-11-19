import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position> getLocation() async {
    if (await Permission.location.isGranted) {
      return Geolocator.getCurrentPosition();
    } else if (await Permission.location.isPermanentlyDenied) {
      throw Exception('Location permission is permanently denied');
    } else {
      await Permission.location.request();
      return getLocation();
    }
  }
}
