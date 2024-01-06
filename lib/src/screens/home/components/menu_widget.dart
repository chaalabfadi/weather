import 'package:flutter/material.dart';
import 'package:weather/src/utils/constante.dart';

class MenuWidget extends StatefulWidget {
  final VoidCallback onPress;
  const MenuWidget({Key? key, required this.onPress}) : super(key: key);

  @override
  MenuWidgetState createState() => MenuWidgetState();
}

class MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ClipPath(
        clipper: FabClipper(),
        child: Container(
          width: 40,
          height: 80,
          decoration: const BoxDecoration(
            color: kPrimaryColor,
          ),
          child: IconButton(
            onPressed: () {
              widget.onPress();
            },
            icon: const Icon(
              Icons.cloud,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class FabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    final width = size.width;
    final height = size.height;
    path.moveTo(width, 0);
    path.quadraticBezierTo(width, 8, width - 10, 16);
    path.quadraticBezierTo(-1, height / 2 - 20, 0, height / 2);
    path.quadraticBezierTo(1, height / 2 + 20, width - 10, height - 16);
    path.quadraticBezierTo(width, height - 8, width, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
