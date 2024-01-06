import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather/src/theme/theme.dart';

import 'src/controllers/weather_controller.dart';
import 'src/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherController(),
        ),
      ],
      child: MaterialApp(
        title: 'Weather',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
