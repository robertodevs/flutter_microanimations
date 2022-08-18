import 'dart:math';

import 'package:flutter/material.dart';

class ExplicitAnimation extends StatefulWidget {
  const ExplicitAnimation({Key? key}) : super(key: key);

  @override
  State<ExplicitAnimation> createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> scale;
  late Animation<double> translate;
  late Animation<double> rotation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    scale = Tween<double>(begin: 1, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutBack,
      ),
    );

    translate = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutBack,
      ),
    );

    rotation = Tween<double>(begin: pi, end: 0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.0,
        0.7,
        curve: Curves.easeIn,
      ),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ScaleTransition(
            //   scale: controller,
            //   child: const Text('MUSTR'),
            // ),
            AnimatedBuilder(
              animation: controller,
              builder: ((context, _) {
                return Transform.rotate(
                  angle: rotation.value,
                  child: Stack(
                    children: [
                      _buildIconButton(
                        angle: 0,
                        icon: Icons.facebook,
                      ),
                      _buildIconButton(
                        angle: -45,
                        icon: Icons.facebook,
                      ),
                      _buildIconButton(
                        angle: -90,
                        icon: Icons.facebook,
                      ),
                      _buildIconButton(
                        angle: -135,
                        icon: Icons.facebook,
                      ),
                      _buildIconButton(
                        angle: -180,
                        icon: Icons.facebook,
                      ),
                      Transform.scale(
                        scale: scale.value - 1,
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          onPressed: () {
                            controller.reverse();
                          },
                          child: const Icon(Icons.close),
                        ),
                      ),
                      Transform.scale(
                        scale: scale.value,
                        child: FloatingActionButton(
                          onPressed: () {
                            controller.forward();
                          },
                          child: const Icon(Icons.menu),
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Transform _buildIconButton({
    required double angle,
    required IconData icon,
  }) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          translate.value * cos(degreeToRadian(angle)),
          translate.value * sin(degreeToRadian(angle)),
        ),
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(icon),
      ),
    );
  }

  double degreeToRadian(double degree) {
    return degree * pi / 180;
  }
}
