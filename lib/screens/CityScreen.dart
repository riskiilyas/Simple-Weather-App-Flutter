import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:oktoast/oktoast.dart';
import 'package:simple_weather_app/blocs/LocationBloc.dart';
import 'package:simple_weather_app/screens/InfoScreen.dart';
import 'package:simple_weather_app/utilities/widgets.dart';

import '../blocs/WeatherBloc.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    var cityController = TextEditingController();
    locationBloc.add(LocationEvent());
    weatherBloc.stream.listen((state) {
      if(state is WeatherStateError) {
        showToast(
            'Error Network Request!',
            position: ToastPosition.bottom
        );
      } else if(state is WeatherStateSuccess) {
        Get.to(InfoScreen(
          weatherModel: state.weather,
          city: state.city,
        ));
        weatherBloc.add(WeatherEventInitial());
      } else if(state is WeatherStateInitial) {
        cityController.clear();
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 32, right: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.topRight,
                begin: Alignment.bottomLeft,
                colors: [
                  Colors.deepPurple[900]!,
                  Colors.black87,
                ]
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                    tag: 'anim',
                    child: SizedBox(
                        width: double.infinity,
                        child: Lottie.asset('assets/main_anim.json')
                    )
                ),
                const Text(
                  'Simple Weather App',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
                const Text(
                  'By KeeCoding',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16
                  ),
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: cityController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.white70,
                            style: BorderStyle.solid
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.blue,
                            style: BorderStyle.solid
                        )
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'City Name...',
                    hintStyle: TextStyle(color: Colors.white70)
                  ),
                ),
                const SizedBox(height: 20,),
                BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherStateLoading) {
                        return const SpinKitWave(
                          color: Colors.white,
                          size: 64,
                        );
                      }
                      return Column(
                        children: [
                          ButtonWidget(
                            onTap: () {
                              weatherBloc.add(WeatherEventFetchByCity(cityController.text));
                            },
                            text: 'Search',
                            color: Colors.redAccent,
                          ),
                          const SizedBox(height: 8,),
                          BlocBuilder<LocationBloc, LocationState>(
                              builder: (context, state) {
                                if (state is LocationStateError) {
                                  showToast(
                                      'Error Getting Location!',
                                      position: ToastPosition.bottom);
                                }
                                return Visibility(
                                    visible: state is LocationStateSuccess,
                                    child: ButtonWidget(
                                        onTap: () {
                                          if(state is LocationStateSuccess) {
                                            weatherBloc.add(WeatherEventFetchByLoc(state.latitude, state.longitude));
                                          }
                                        },
                                        text: 'My Location'
                                    )
                                );
                              }
                          )
                        ],
                      );
                    })
              ],
            ),
          ),
        ),
      );
  }
}