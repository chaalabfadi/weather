import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/src/controllers/weather_controller.dart';

class BackgroundHome extends StatelessWidget {
  const BackgroundHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherController>(
      builder: (context, controller, child) {
        return Image.asset(
          controller.path,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
