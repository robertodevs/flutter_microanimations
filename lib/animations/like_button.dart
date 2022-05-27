import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_microanimations/animations/style/colors.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  Color disabledColor = Colors.white;
  Color enabledColor = Colors.black;
  double angle = 0;
  bool enabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() {
            enabled = !enabled;
            angle = pi / 18.0;
          }),
          child: AnimatedContainer(
            width: 125,
            height: 50,
            decoration: BoxDecoration(
              color: enabled ? enabledColor : disabledColor,
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  tween: Tween<double>(
                    begin: angle,
                    end: angle,
                  ),
                  onEnd: () {
                    if (angle == pi / 18.0) {
                      setState(() => angle = -pi / 18.0);
                    } else {
                      setState(() => angle = 0);
                    }
                  },
                  builder: (_, double value, __) {
                    return Transform.rotate(
                      angle: value,
                      child: Icon(
                        enabled ? Icons.favorite : Icons.favorite_border,
                        color: enabled ? disabledColor : enabledColor,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                Text(
                  'LIKE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: enabled ? disabledColor : enabledColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
