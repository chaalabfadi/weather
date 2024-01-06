import 'package:flutter/material.dart';
import 'package:weather/src/utils/constante.dart';

class DividerBottom extends StatelessWidget {
  const DividerBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Container(
          height: 1.5,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(4),
              right: Radius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
