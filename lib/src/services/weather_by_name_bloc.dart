import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather/src/controllers/audio_controller_name.dart';
import 'package:weather/src/controllers/weather_controller.dart';
import 'package:weather/src/models/weather.dart';
import 'package:weather/src/services/response.dart';

class WeatherByNameBloc {
  ResponseApi responseApi = ResponseApi();
  final BehaviorSubject<Weather> _subject = BehaviorSubject<Weather>();
  final controller = WeatherController();
  final audioController = AudioByNameController();
  DateTime nowDate = DateTime.now();
  DateTime? sunrise;
  DateTime? sunset;

  getWeatherByName(String city) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      Weather? weather = await responseApi.getWeatherInfoByQuery(city);
      if (weather?.weather.first.main == 'Clear') {
        sunrise =
            DateTime.fromMillisecondsSinceEpoch(weather!.sys.sunrise * 1000);
        sunset = DateTime.fromMillisecondsSinceEpoch(weather.sys.sunset * 1000);
      } else if (weather?.weather.first.main == 'Clouds') {
      } else if (weather?.weather.first.main == 'Rain') {
      } else if (weather?.weather.first.main == 'Thunderstorm') {}
      if (weather != null) _subject.sink.add(weather);
    } else {
      _subject.sink.addError("No internet connection");
    }
  }

  void dispose() {
    _subject.close();
  }

  BehaviorSubject<Weather> get subject => _subject;
}

final weatherByNameBloc = WeatherByNameBloc();
