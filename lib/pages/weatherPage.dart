import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/services/weatherServices.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherServices = WeatherServices('7b61dc28f462ef1986dd3486dd930da1');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherServices.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherServices.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // weather Animation
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null) return 'assets/sunnyAnimation.json';

    switch(mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smok':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudAnimation.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rianAnimation.json';
      case 'thunderstorm':
        return 'assets/thanderAnimation.json';
      case 'clear':
        return 'assets/sunnyAnimation.json';
      default: 
        return 'assets/sunnyAnimation.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    // fatch weather on setup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // text name
          Text(_weather?.cityName ?? "Loading city.."),

          // Animation // cloudAnimation // rianAnimation  // sunnyAnimation  // thanderAnimation
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          // temperature
          Text('${_weather?.temperature}°C'),

          // main condetion
          Text(_weather?.mainCondition ?? ""),
        ],
      ),
    ));
  }
}
