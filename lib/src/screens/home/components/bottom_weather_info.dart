import 'package:flutter/material.dart';
import 'package:weather/src/utils/constante.dart';

class BottomWeatherInfo extends StatelessWidget {
  final String humidity;
  final String pressure;
  final String speed;
  const BottomWeatherInfo(
      {Key? key,
      required this.humidity,
      required this.pressure,
      required this.speed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '$humidity%',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w900,
                            fontFamily: 'KongScript',
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Text(
                        'Humidity',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Arquitecta',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const VerticalDivider(),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          pressure,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w900,
                            fontFamily: 'KongScript',
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Text(
                        'Pressure',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Arquitecta',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const VerticalDivider(),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          speed,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w900,
                            fontFamily: 'KongScript',
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Text(
                        'Wind Speed',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Arquitecta',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
