import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_weather_app/models/WeatherModel.dart';
import 'package:simple_weather_app/utilities/widgets.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({required this.weatherModel,required this.city, Key? key}) : super(key: key);

  final String city;
  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
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
                  child: Lottie.asset('assets/main_anim.json')
              ),
              Text(
                city.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "${weatherModel.getTemp.toStringAsFixed(1)}C",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                ),
              ),
              const Text(
                'Temperature',
                style: TextStyle(
                    color: Colors.white70
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "${weatherModel.getMinTemp.toStringAsFixed(1)}C",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'Min Temperature',
                        style: TextStyle(
                            color: Colors.white70
                        ),
                      )                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "${weatherModel.getMaxTemp.toStringAsFixed(1)}C",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                          'Max Temperature',
                        style: TextStyle(
                          color: Colors.white70
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              ButtonWidget(
                  onTap: () {
                    Get.back();
                  },
                  text: 'Back To Search'
              )
            ],
          ),
        ),
      ),
    );
  }
}
