import 'package:simple_weather_app/services/location.dart';
import 'package:simple_weather_app/services/networking.dart';

class ServiceLocator {
  static Location? _location;
  static WeatherNetwork? _weatherNetwork;

  static Location getLocation() {
    _location ??= Location();
    return _location!;
  }

  static WeatherNetwork getWeatherNetwork() {
    _weatherNetwork ??= WeatherNetwork();
    return _weatherNetwork!;
  }
}