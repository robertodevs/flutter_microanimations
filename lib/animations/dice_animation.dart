import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_microanimations/animations/style/colors.dart';

class DiceAnimation extends StatefulWidget {
  const DiceAnimation({Key? key}) : super(key: key);

  @override
  State<DiceAnimation> createState() => _DiceAnimationState();
}

class _DiceAnimationState extends State<DiceAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> diceRotation;
  late Animation<double> diceRotation2;
  late Animation<double> yPosition;
  late Animation<double> yPosition2;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    diceRotation = Tween<double>(
      begin: pi / 12,
      end: -pi + pi / 12,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1, curve: Curves.easeInOutSine),
      ),
    );

    diceRotation2 = Tween<double>(
      begin: -pi / 12,
      end: -pi / 12 - pi,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1, curve: Curves.easeInOutSine),
      ),
    );
    yPosition = Tween<double>(
      begin: 0,
      end: -10,
    ).animate(
      CurvedAnimation(
          parent: controller,
          curve: const Interval(0, 0.5, curve: Curves.easeIn)),
    );

    yPosition2 = Tween<double>(
      begin: -10,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: GestureDetector(
          onTap: (() {
            controller.forward(
              from: 0,
            );
          }),
          child: Container(
            width: 220,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: secondaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildDiceAnimation(),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Shuffle Suggestions',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AnimatedBuilder _buildDiceAnimation() {
    return AnimatedBuilder(
      animation: controller.view,
      builder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, yPosition.value + yPosition2.value),
              child: Transform.rotate(
                angle: diceRotation.value,
                child: Image.asset(
                  'assets/dice1.png',
                  width: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Transform.translate(
              offset: Offset(0, yPosition.value + yPosition2.value),
              child: Transform.rotate(
                angle: diceRotation2.value,
                child: Image.asset(
                  'assets/dice2.png',
                  width: 16.0,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
