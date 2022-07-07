import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_microanimations/animations/style/colors.dart';

class GradientPlayButton extends StatefulWidget {
  const GradientPlayButton({Key? key}) : super(key: key);

  @override
  State<GradientPlayButton> createState() => _GradientPlayButtonState();
}

class _GradientPlayButtonState extends State<GradientPlayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> circularProgressRotation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this)
      ..repeat();
    circularProgressRotation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: _buildCard(),
      ),
    );
  }

  Widget _buildCard() {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 170,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  offset: const Offset(5, 5),
                  blurRadius: 30,
                ),
              ],
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/card.png'),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: AnimatedBuilder(
            animation: controller.view,
            child: _buildPlayButton(),
            builder: (context, child) {
              return Stack(
                children: [
                  Transform.rotate(
                    angle: circularProgressRotation.value,
                    child: Center(
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.0),
                          gradient: SweepGradient(
                            startAngle: 3 * pi / 2,
                            endAngle: 7 * pi / 2,
                            tileMode: TileMode.repeated,
                            stops: const [0.0, 1],
                            colors: [
                              primaryColor.withOpacity(.3),
                              secondaryColor,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(child: child),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlayButton() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(2),
        child: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black,
          child: Icon(
            Icons.play_arrow,
            size: 40,
          ),
        ),
      ),
    );
  }
}
