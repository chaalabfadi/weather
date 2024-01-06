import 'package:flutter/material.dart';
import 'package:weather/src/utils/constante.dart';

class WeatherInfo extends StatelessWidget {
  final String city;
  final String temp;
  const WeatherInfo({Key? key, required this.city, required this.temp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              city.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$temp°',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 154,
                    fontFamily: 'KongScript',
                  ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
