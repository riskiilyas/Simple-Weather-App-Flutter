import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather_app/models/WeatherModel.dart';
import 'package:simple_weather_app/services/networking.dart';
import 'package:simple_weather_app/utilities/ServiceLocator.dart';

///////////////////// EVENT ///////////////////
class WeatherEvent {}

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
  WeatherStateSuccess(this.weather);
}

///////////////////// BLoC ///////////////////
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherNetwork _weatherNetwork = ServiceLocator.getWeatherNetwork();

  WeatherBloc(): super(WeatherStateInitial()) {
    on<WeatherEventFetchByCity>((event, emit) async {
        emit(WeatherStateLoading());
        try {
          final model = await _weatherNetwork.getWeatherByCity(event.city);
          emit(WeatherStateSuccess(model));
        } catch (e) {
          emit(WeatherStateError());
        }
    });

    on<WeatherEventFetchByLoc>((event, emit) async {
      emit(WeatherStateLoading());
      try {
        final model = await _weatherNetwork.getWeatherByLoc(event.latitude, event.longitude);
        emit(WeatherStateSuccess(model));
      } catch (e) {
        emit(WeatherStateError());
      }
    });
  }

}