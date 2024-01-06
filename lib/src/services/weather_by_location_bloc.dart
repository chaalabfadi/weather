import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:location/location.dart';
import 'package:rxdart/subjects.dart';
import 'package:weather/src/controllers/audio_controller.dart';
import 'package:weather/src/controllers/weather_controller.dart';
import 'package:weather/src/models/weather.dart';
import 'package:weather/src/services/response.dart';

class WeatherByLocationBloc {
  ResponseApi responseApi = ResponseApi();
  final BehaviorSubject<Weather> _subject = BehaviorSubject<Weather>();
  final controller = WeatherController();
  final audioController = AudioController();
  DateTime nowDate = DateTime.now();
  DateTime? sunrise;
  DateTime? sunset;

  getWeatherByLocation() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      LocationData? locationData = await controller.getUserLocation();
      Weather? weather = await responseApi.getWeatherInfoByLocation(
          locationData!.longitude!, locationData.latitude!);
      log(weather.toString());
      if (weather != null) {
        if (weather.weather.first.main == 'Clear') {
          sunrise =
              DateTime.fromMillisecondsSinceEpoch(weather.sys.sunrise * 1000);
          sunset =
              DateTime.fromMillisecondsSinceEpoch(weather.sys.sunset * 1000);
          if (nowDate.compareTo(sunrise!) == 1 &&
              nowDate.compareTo(sunset!) == -1) {
            controller.path = 'assets/images/sunny.gif';
            audioController.path = 'sounds/sunny.mp3';
          } else {
            controller.path = 'assets/images/night-montain.gif';
            audioController.path = 'sounds/nightime.mp3';
          }
        } else if (weather.weather.first.main == 'Clouds') {
          controller.path = 'assets/images/original.gif';
          audioController.path = 'sounds/wind.mp3';
        } else if (weather.weather.first.main == 'Rain') {
          controller.path = 'assets/images/rain-montain.gif';
          audioController.path = 'sounds/rain.mp3';
        } else if (weather.weather.first.main == 'Thunderstorm') {
          controller.path = 'assets/images/thunder-rain.gif';
          audioController.path = 'sounds/storm.mp3';
        }
        _subject.sink.add(weather);
      } else {
        _subject.sink.addError("Error");
      }
    } else {
      _subject.sink.addError("No internet connection");
    }
  }

  void dispose() {
    _subject.close();
  }

  BehaviorSubject<Weather> get subject => _subject;
}

final weatherByLocationBloc = WeatherByLocationBloc();
