import 'package:flutter/material.dart';

class FloatingIcon extends StatefulWidget {
  final String iconPath;

  const FloatingIcon({Key? key, required this.iconPath}) : super(key: key);

  @override
  _FloatingIconState createState() => _FloatingIconState();
}

class _FloatingIconState extends State<FloatingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    // Floating animation (up and down)
    _floatAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );

    // Shaking animation (slight rotation)
    _shakeAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value), // Move up and down
          child: Transform.rotate(
            angle: _shakeAnimation.value, // Rotate for shaking effect
            child: Image.asset(
              widget.iconPath,
              width: 100,
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
