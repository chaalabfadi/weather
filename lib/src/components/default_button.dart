import 'package:flutter/material.dart';
import 'package:weather/src/utils/constante.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            letterSpacing: 0.056,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
