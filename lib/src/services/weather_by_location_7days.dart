import 'package:connectivity/connectivity.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather/src/controllers/weather_controller.dart';
import 'package:weather/src/models/weekly_weather.dart';
import 'package:weather/src/services/response.dart';

class WeatherByLocation7DaysBloc {
  ResponseApi responseApi = ResponseApi();
  final BehaviorSubject<WeeklyWeather> _subject =
      BehaviorSubject<WeeklyWeather>();
  final controller = WeatherController();

  getWeatherByLocation7Days() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      LocationData? locationData = await controller.getUserLocation();
      WeeklyWeather? weather = await responseApi.getWeatherInfoByLocation7Days(
          locationData!.longitude!, locationData.latitude!);
      _subject.sink.add(weather!);
    } else {
      _subject.sink.addError("No internet connection");
    }
  }

  BehaviorSubject<WeeklyWeather> get subject => _subject;

  void dispose() {
    _subject.close();
  }
}

final weatherByLocation7DaysBloc = WeatherByLocation7DaysBloc();
