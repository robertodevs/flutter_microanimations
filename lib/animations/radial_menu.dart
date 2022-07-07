import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_microanimations/animations/style/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RadialMenu extends StatefulWidget {
  const RadialMenu({Key? key}) : super(key: key);

  @override
  State<RadialMenu> createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu> with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> scale;
  late Animation<double> translate;
  late Animation<double> opacity;
  late Animation<double> rotation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    scale = Tween<double>(begin: 1, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOutBack),
    );
    translate = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutBack,
      ),
    );
    opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.3, .5),
      ),
    );
    rotation = Tween<double>(begin: pi, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, .7, curve: Curves.easeInOut),
      ),
    );
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: AnimatedBuilder(
            animation: controller.view,
            builder: (context, _) {
              return Transform.rotate(
                angle: rotation.value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildMenuOption(
                        angle: 0,
                        icon: const Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                        color: const Color(0xFF0073F5)),
                    _buildMenuOption(
                      angle: -45,
                      icon: const Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.white,
                      ),
                      color: const Color(0xFFFF0F5C),
                    ),
                    _buildMenuOption(
                      angle: -90,
                      icon: const Icon(
                        FontAwesomeIcons.twitter,
                        color: Colors.white,
                      ),
                      color: const Color(0xFF1D9CEF),
                    ),
                    _buildMenuOption(
                      angle: -135,
                      icon: const Icon(
                        FontAwesomeIcons.youtube,
                        color: Colors.white,
                      ),
                      color: const Color(0xFFFF0200),
                    ),
                    _buildMenuOption(
                      angle: 180,
                      icon: const Icon(
                        FontAwesomeIcons.github,
                        color: Colors.white,
                      ),
                      color: const Color(0xFF24292E),
                    ),
                    Transform.scale(
                      scale: scale.value - 1,
                      child: FloatingActionButton(
                        backgroundColor: Colors.red,
                        onPressed: _close,
                        child: const Icon(Icons.close),
                      ),
                    ),
                    Transform.scale(
                      scale: scale.value,
                      child: FloatingActionButton(
                        backgroundColor: Colors.green,
                        onPressed: _open,
                        child: const Icon(Icons.menu),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _buildMenuOption({
    required double angle,
    required Widget icon,
    required Color color,
  }) {
    return Opacity(
      opacity: opacity.value,
      child: Transform(
        transform: Matrix4.identity()
          ..translate(
            translate.value * cos(degreeToRadian(angle)),
            translate.value * sin(degreeToRadian(angle)),
          ),
        child: FloatingActionButton(
          backgroundColor: color,
          child: icon,
          onPressed: () {},
        ),
      ),
    );
  }

  double degreeToRadian(double degree) {
    return degree * pi / 180;
  }
}
