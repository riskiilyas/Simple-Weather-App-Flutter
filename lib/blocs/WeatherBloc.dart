import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:simple_weather_app/models/WeatherModel.dart';
import 'package:simple_weather_app/services/networking.dart';
import 'package:simple_weather_app/utilities/ServiceLocator.dart';

///////////////////// EVENT ///////////////////
class WeatherEvent {}

class WeatherEventInitial extends WeatherEvent {}

class WeatherEventFetchByCity extends WeatherEvent {
  final String city;

  WeatherEventFetchByCity(this.city);
}

class WeatherEventFetchByLoc extends WeatherEvent {
  final double latitude, longitude;

  WeatherEventFetchByLoc(this.latitude, this.longitude);
}

///////////////////// STATE ///////////////////
class WeatherState{}

class WeatherStateInitial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateError extends WeatherState {}

class WeatherStateSuccess extends WeatherState {
  final WeatherModel weather;
  final String city;
  WeatherStateSuccess(this.weather, this.city);
}

///////////////////// BLoC ///////////////////
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherNetwork _weatherNetwork = ServiceLocator.getWeatherNetwork();

  WeatherBloc(): super(WeatherStateInitial()) {
    on<WeatherEventFetchByCity>((event, emit) async {
        emit(WeatherStateLoading());
        try {
          final model = await _weatherNetwork.getWeatherByCity(event.city);
          emit(WeatherStateSuccess(model, event.city));
        } catch (e) {
          emit(WeatherStateError());
        }
    });

    on<WeatherEventFetchByLoc>((event, emit) async {
      emit(WeatherStateLoading());
      try {
        final model = await _weatherNetwork.getWeatherByLoc(event.latitude, event.longitude);
        final address = await GeoCode().reverseGeocoding(latitude: event.latitude, longitude: event.longitude);
        emit(WeatherStateSuccess(model, address.city ?? "Unknown City"));
      } catch (e) {
        emit(WeatherStateError());
      }
    });

    on<WeatherEventInitial>((event, emit) async{
      emit(WeatherStateInitial());
    });
  }

}