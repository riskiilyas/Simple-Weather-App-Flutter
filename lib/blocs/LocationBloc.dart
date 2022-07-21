import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather_app/services/location.dart';
import 'package:simple_weather_app/utilities/ServiceLocator.dart';

///////////////////// EVENT /////////////////////
class LocationEvent{}

///////////////////// STATE ///////////////////
class LocationState{}

class LocationStateInitial extends LocationState {}

class LocationStateError extends LocationState {}

class LocationStateSuccess extends LocationState {
  final double latitude, longitude;
  LocationStateSuccess(this.latitude, this.longitude);
}

///////////////////// BLoC /////////////////////
class LocationBloc extends Bloc<LocationEvent, LocationState> {

  final Location _location = ServiceLocator.getLocation();

  LocationBloc() : super(LocationStateInitial()) {
    on<LocationEvent>((event, emit) async {
          emit(LocationStateInitial());
          await _location.getCurrentLocation();
          if(_location.isSuccess) {
            emit(LocationStateSuccess(_location.latitude, _location.longitude));
          } else {
            emit(LocationStateError());
          }
    });
  }
}