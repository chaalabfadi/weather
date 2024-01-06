import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/src/controllers/audio_controller.dart';
import 'package:weather/src/models/weather.dart';
import 'package:weather/src/screens/home/components/background_home.dart';
import 'package:weather/src/screens/home/components/bottom_weather_info.dart';
import 'package:weather/src/screens/home/components/menu_stack.dart';
import 'package:weather/src/screens/home/components/rotated_text_info.dart';
import 'package:weather/src/screens/home/components/weather_info.dart';
import 'package:weather/src/services/weather_by_location_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final audioController = AudioController();
  @override
  void initState() {
    weatherByLocationBloc.getWeatherByLocation();
    super.initState();
  }

  @override
  void dispose() {
    audioController.stopLocalAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Weather>(
        stream: weatherByLocationBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String? city = snapshot.data!.name == "B\u012bnshangul Gumuz"
                ? "Sayada"
                : snapshot.data!.name;
            String temp =
                (snapshot.data!.main.temp - 273.15).round().toString();
            String description = snapshot.data!.weather.first.description;
            String humidity = snapshot.data!.main.humidity.toString();
            String pressure = snapshot.data!.main.pressure.toString();
            String speed = snapshot.data!.wind.speed.toString();
            audioController.playLocal();
            return Stack(
              fit: StackFit.expand,
              children: [
                const BackgroundHome(),
                WeatherInfo(
                  city: city,
                  temp: temp,
                ),
                RotatedTextInfo(
                  description: description,
                ),
                BottomWeatherInfo(
                  humidity: humidity,
                  pressure: pressure,
                  speed: speed,
                ),
                const MenuFab(),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Lottie.asset('assets/images/error-404-page.json'),
            );
          } else {
            return Center(
              child: Lottie.asset('assets/images/preload.json'),
            );
          }
        },
      ),
    );
  }
}
