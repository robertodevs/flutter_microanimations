import 'package:flutter/material.dart';
import 'package:flutter_microanimations/animations/style/colors.dart';

class ButtonLoop extends StatefulWidget {
  const ButtonLoop({Key? key}) : super(key: key);

  @override
  State<ButtonLoop> createState() => _ButtonLoopState();
}

class _ButtonLoopState extends State<ButtonLoop> {
  double buttonScale = 1.0;

  @override
  Widget build(BuildContext context) {
    double buttonScale = 1.0;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInOut,
          tween: Tween<double>(
            begin: 0.2,
            end: buttonScale,
          ),
          onEnd: () {
            if (buttonScale == 1) {
              setState(() => buttonScale = 0.9);
            } else {
              setState(() => buttonScale = 1.0);
            }
          },
          builder: (_, double value, __) {
            return Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Transform.scale(
                scale: value,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/animations/shazam.png'),
                  width: 150,
                  height: 150,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
