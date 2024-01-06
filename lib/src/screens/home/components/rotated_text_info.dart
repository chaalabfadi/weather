import 'package:flutter/material.dart';

class RotatedTextInfo extends StatelessWidget {
  final String description;
  const RotatedTextInfo({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: 60,
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          description,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
