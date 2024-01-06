import 'package:flutter/material.dart';

class AnimatedFab extends StatefulWidget {
  final VoidCallback onClick;

  const AnimatedFab({Key? key, required this.onClick}) : super(key: key);

  @override
  AnimatedFabState createState() => AnimatedFabState();
}

class AnimatedFabState extends State<AnimatedFab>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Color>? _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _colorAnimation = ColorTween(begin: Colors.pink, end: Colors.pink[800])
        .animate(_animationController!) as Animation<Color>?;
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (BuildContext context, Widget? child) {
        return _buildFabCore();
      },
    );
  }

  Widget _buildFabCore() {
    return FloatingActionButton(
      onPressed: _onFabTap,
      backgroundColor: _colorAnimation!.value,
      child: const Icon(Icons.filter_list),
    );
  }

  open() {
    if (_animationController!.isDismissed) {
      _animationController?.forward();
    }
  }

  close() {
    if (_animationController!.isCompleted) {
      _animationController?.reverse();
    }
  }

  _onFabTap() {
    if (_animationController!.isDismissed) {
      open();
    } else {
      close();
    }
  }
}
