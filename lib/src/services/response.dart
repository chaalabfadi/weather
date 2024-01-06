import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather/src/models/weather.dart' as weather;
import 'package:weather/src/models/weekly_weather.dart';

class ResponseApi {
  static final client = http.Client();
  static const baseUrl = "https://open-weather13.p.rapidapi.com/";

  Future<weather.Weather?> getWeatherInfoByQuery(String city) async {
    Uri url = Uri.parse("${baseUrl}city/$city");
    var res = await client.get(url, headers: {
      'x-rapidapi-key': 'bfa9ad5fd2mshb1475e9c0fbbb23p18864ajsn360acec4a1c3',
      'x-rapidapi-host': 'open-weather13.p.rapidapi.com'
    });

    if (res.statusCode == 200) {
      var data = res.body;
      log(data);
      return weather.weatherFromMap(data);
    } else {
      return null;
    }
  }

  Future<weather.Weather?> getWeatherInfoByLocation(
      double lon, double lat) async {
    try {
      Uri url = Uri.parse("${baseUrl}city/latlon/$lon/$lat");
      var res = await client.get(url, headers: {
        'x-rapidapi-key': 'bfa9ad5fd2mshb1475e9c0fbbb23p18864ajsn360acec4a1c3',
        'x-rapidapi-host': 'open-weather13.p.rapidapi.com'
      });

      if (res.statusCode == 200) {
        var data = res.body;
        log(data);
        return weather.weatherFromMap(data);
      } else {
        log(res.statusCode.toString());
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<WeeklyWeather?> getWeatherInfoByLocation7Days(
      double lon, double lat) async {
    Uri url = Uri.parse("${baseUrl}city/fivedaysforcast/$lon/$lat");
    var res = await client.get(url, headers: {
      'x-rapidapi-key': 'bfa9ad5fd2mshb1475e9c0fbbb23p18864ajsn360acec4a1c3',
      'x-rapidapi-host': 'open-weather13.p.rapidapi.com'
    });

    if (res.statusCode == 200) {
      var data = res.body;
      log(data);
      return weeklyWeatherFromMap(data);
    } else {
      return null;
    }
  }
}
