import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _buttonController;
  final DecorationTween _decorationTween = DecorationTween(
    begin: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.2, 1],
        colors: [
          Color(0xFFFDC830),
          Color(0xFFF37335),
        ],
      ),
    ),
    end: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.2, 1],
        colors: [
          Color(0xFFb21f1f),
          Color(0xFF1a2a6c),
        ],
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: DecoratedBoxTransition(
          decoration: _decorationTween.animate(_buttonController),
          child: const SizedBox(),
        ),
      ),
    );
  }
}
