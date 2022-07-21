import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0;
  double longitude = 0;
  bool isSuccess = false;

  Future<void> getCurrentLocation() async {
    isSuccess = false;
    try {
      Position position = await Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;
      isSuccess = true;
    } catch (e) {
      isSuccess = false;
    }
  }
}

class LocationState {

}
