import 'package:flutter/material.dart';
import 'package:weather/src/components/circular_button.dart';
import 'package:weather/src/screens/home/components/menu_widget.dart';
import 'package:weather/src/screens/home/components/weather_week_info.dart';
import 'package:weather/src/utils/constante.dart';

import '../../search/search_screen.dart';

class MenuFab extends StatefulWidget {
  const MenuFab({Key? key}) : super(key: key);

  @override
  MenuFabState createState() => MenuFabState();
}

class MenuFabState extends State<MenuFab> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  Animation? degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation? rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        IgnorePointer(
          child: Container(
            color: Colors.transparent,
            height: 150.0,
            width: 150.0,
          ),
        ),
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(220),
              degOneTranslationAnimation!.value * 100),
          child: Transform(
            transform: Matrix4.rotationZ(
                getRadiansFromDegree(rotationAnimation!.value))
              ..scale(degOneTranslationAnimation!.value),
            alignment: Alignment.center,
            child: CircularButton(
              color: kDarkPrimaryColor,
              width: 50,
              height: 50,
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onClick: () async {
                // Display search delegate
                await showSearch(
                  context: context,
                  delegate: SearchScreen(),
                );
              },
            ),
          ),
        ),
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(140),
              degTwoTranslationAnimation!.value * 100),
          child: Transform(
            transform: Matrix4.rotationZ(
                getRadiansFromDegree(rotationAnimation!.value))
              ..scale(degTwoTranslationAnimation!.value),
            alignment: Alignment.center,
            child: CircularButton(
              color: kContrastColor,
              width: 50,
              height: 50,
              icon: const Icon(
                Icons.folder_open_rounded,
                color: Colors.white,
              ),
              onClick: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  builder: (context) {
                    return const WeatherWeekInfo();
                  },
                );
              },
            ),
          ),
        ),
        MenuWidget(
          onPress: () {
            if (animationController.isCompleted) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
          },
        ),
      ],
    );
  }
}
