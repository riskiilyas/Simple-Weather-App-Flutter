import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:simple_weather_app/screens/CityScreen.dart';

import 'blocs/LocationBloc.dart';
import 'blocs/WeatherBloc.dart';

void main() {
  runApp(OKToast(
    child: MaterialApp(
      home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LocationBloc()),
            BlocProvider(create: (context) => WeatherBloc())
          ],
          child: CityScreen(),
      ),
      theme: ThemeData.dark(),
    ),
  ));
}