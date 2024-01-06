import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/src/models/weekly_weather.dart';
import 'package:weather/src/services/weather_by_location_7days.dart';
import 'package:weather/src/utils/constante.dart';

class WeatherWeekInfo extends StatefulWidget {
  const WeatherWeekInfo({Key? key}) : super(key: key);

  @override
  WeatherWeekInfoState createState() => WeatherWeekInfoState();
}

class WeatherWeekInfoState extends State<WeatherWeekInfo> {
  @override
  void initState() {
    weatherByLocation7DaysBloc.getWeatherByLocation7Days();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      onClosing: () {},
      builder: (context) {
        return SizedBox(
          // height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Card(
              color: Colors.white,
              elevation: 0.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              margin: const EdgeInsets.all(0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: const Column(
                  children: <Widget>[
                    SizedBox(height: 12),
                    CustomDraggingHandle(),
                    SizedBox(height: 40),
                    CustomWeeklyWeatherText(),
                    SizedBox(height: 20),
                    CustomWeeklyWeatherItem(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomDraggingHandle extends StatelessWidget {
  const CustomDraggingHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class CustomWeeklyWeatherText extends StatelessWidget {
  const CustomWeeklyWeatherText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: <Widget>[
          Text(
            "Weekly Weather",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: kContrastColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class CustomWeeklyWeatherItem extends StatelessWidget {
  const CustomWeeklyWeatherItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: CustomWeekItem(),
    );
  }
}

class CustomWeekItem extends StatelessWidget {
  const CustomWeekItem({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WeeklyWeather>(
      stream: weatherByLocation7DaysBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.list.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              ListElement item = snapshot.data!.list[index];
              String temp = (item.main.temp - 273.15).round().toString();
              String description = item.weather.first.description;
              String icon =
                  "http://openweathermap.org/img/w/${item.weather.first.icon}.png";
              DateTime dayTime = item.dtTxt;
              String day = DateFormat('EEEE').format(dayTime);
              // Remove duplicate day and show time instead
              if (index > 0) {
                DateTime dayTimePrev = snapshot.data!.list[index - 1].dtTxt;
                String dayPrev = DateFormat('EEEE').format(dayTimePrev);
                if (day == dayPrev) {
                  day = DateFormat('HH:mm').format(dayTime);
                }
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        day,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                      ),
                    ),
                    const VerticalDivider(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$temp°',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color: kSecondaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  fontFamily: 'KongScript',
                                ),
                          ),
                          Text(
                            description,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: kTextColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    Flexible(fit: FlexFit.loose, child: Image.network(icon)),
                  ],
                ),
              );
            },
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
    );
  }
}
