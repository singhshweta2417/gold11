// rotating_container.dart
import 'package:flutter/material.dart';

class RotationAnimation extends StatefulWidget {
  final Widget child;
  
  const RotationAnimation({super.key, required this.child});
  @override
  _RotationAnimationState createState() => _RotationAnimationState();
}

class _RotationAnimationState extends State<RotationAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: ( context, child) {
          return Transform.rotate(
            angle: _controller.value * 2.0 * 3.141592653589793,
            child: child,
          );
        },
      ),
    );
  }
}
