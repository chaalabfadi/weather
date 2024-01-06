import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/src/controllers/audio_controller_name.dart';
import 'package:weather/src/models/weather.dart';
import 'package:weather/src/services/weather_by_name_bloc.dart';
import 'package:weather/src/utils/constante.dart';

class SearchScreen extends SearchDelegate {
  final audioController = AudioByNameController();
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) weatherByNameBloc.getWeatherByName(query);
    return StreamBuilder<Weather>(
        stream: weatherByNameBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String? city = snapshot.data!.name == "Seïada"
                ? "Sayada"
                : snapshot.data!.name;
            String temp =
                ((snapshot.data!.main.temp - 32) * 5 / 9).round().toString();
            String description = snapshot.data!.weather.first.description;
            String icon =
                "http://openweathermap.org/img/w/${snapshot.data!.weather.first.icon}.png";
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              child: ListTile(
                leading: Text(city),
                title: Text(temp),
                subtitle: Text(description),
                trailing: Image.network(icon),
              ),
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
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("Search for a city"),
    );
  }
}
