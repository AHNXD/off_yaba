import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<bool> checkGps() async {
    bool servicestatus = await Geolocator.isLocationServiceEnabled();
    bool haspermission;
    if (servicestatus) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          haspermission = false;
        } else if (permission == LocationPermission.deniedForever) {
          haspermission = false;
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
    }
    haspermission = false;

    return haspermission;
  }

  static Future<Position> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457
    return position;

    // Reverse geocoding
    // try {
    //   List<Placemark> placemarks =
    //       await placemarkFromCoordinates(position.latitude, position.longitude);
    //   Placemark placemark = placemarks[0];

    //   locationName = locationName =
    //       "${placemark.country},${placemark.locality},${placemark.subLocality},${placemark.thoroughfare}";
    // } catch (e) {
    //   print("Error fetching location name: $e");
    // }
  }
}
