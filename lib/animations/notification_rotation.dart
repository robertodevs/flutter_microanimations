import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_microanimations/animations/style/colors.dart';

class NotificationRotation extends StatefulWidget {
  const NotificationRotation({Key? key}) : super(key: key);

  @override
  State<NotificationRotation> createState() => _NotificationRotationState();
}

class _NotificationRotationState extends State<NotificationRotation> {
  double angle = pi / 12.0;

  @override
  Widget build(BuildContext context) {
    return 
Scaffold(
  backgroundColor: primaryColor,
  body: Center(
    child: TweenAnimationBuilder(
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
      tween: Tween<double>(
        begin: -pi / 12.0,
        end: angle,
      ),
      onEnd: () {
        if (angle == pi / 12.0) {
          setState(() {
            angle = -pi / 12.0;
          });
        } else {
          setState(() {
            angle = 0;
          });
        }
      },
      builder: (_, double value, __) {
        return Transform.rotate(
          angle: value,
          child: Stack(
            children: const [
              Icon(
                Icons.notifications,
                size: 30,
                color: Colors.white,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 8,
                  child: Text(
                    '2',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    ),
  ),
);
  }
}
