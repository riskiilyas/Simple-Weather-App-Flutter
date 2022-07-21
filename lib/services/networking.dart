import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/WeatherModel.dart';

const String TOKEN = "96cb74b7c2fcfcf2ce4436d20737f6ab";
class WeatherNetwork {

  Future<WeatherModel> getWeatherByLoc(double latitude, double longitude) async{
    // final result = await http.Client().get("https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2");
    final result = await http.Client().get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&APPID=$TOKEN"));
    
    if(result.statusCode != 200) {
      throw Exception();
    }

    return parsedJson(result.body);
  }
  
  
  Future<WeatherModel> getWeatherByCity(String city) async{
    final result = await http.Client().get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$TOKEN"));

    if(result.statusCode != 200) {
      throw Exception();
    }

    return parsedJson(result.body);
  }

  WeatherModel parsedJson(final response){
    final jsonDecoded = json.decode(response);

    final jsonWeather = jsonDecoded["main"];

    return WeatherModel.fromJson(jsonWeather);
  }
}