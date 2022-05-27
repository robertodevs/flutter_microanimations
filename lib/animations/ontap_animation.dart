import 'package:flutter/material.dart';
import 'package:flutter_microanimations/animations/style/colors.dart';

class OnTapAnimation extends StatefulWidget {
  const OnTapAnimation({Key? key}) : super(key: key);

  @override
  State<OnTapAnimation> createState() => _OnTapAnimationState();
}

class _OnTapAnimationState extends State<OnTapAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController playController;

  late Animation<double> scaleCircle1;
  late Animation<double> scaleCircle2;
  late Animation<double> scaleCircle3;

  late Animation<double> opacityCircle1;
  late Animation<double> opacityCircle2;
  late Animation<double> opacityCircle3;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    playController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    scaleCircle3 = getScaleAnimation(0.0, 0.3);
    scaleCircle1 = getScaleAnimation(0.1, .6);
    scaleCircle2 = getScaleAnimation(0.3, 0.8);

    opacityCircle3 = getOpacityAnimation(.6, 1.0);
    opacityCircle1 = getOpacityAnimation(.2, .6);
    opacityCircle2 = getOpacityAnimation(.5, 0.8);
    super.initState();
  }

  Animation<double> getScaleAnimation(double lowLimit, double upperLimit) {
    return Tween<double>(
      begin: 0.0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          lowLimit,
          upperLimit,
          curve: Curves.easeInOutSine,
        ),
      ),
    );
  }

  Animation<double> getOpacityAnimation(double lowLimit, double upperLimit) {
    return Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(lowLimit, upperLimit, curve: Curves.easeOut),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: controller.view,
              builder: (context, _) {
                return Stack(
                  children: [
                    Opacity(
                      opacity: opacityCircle1.value,
                      child: _buildCircle(
                        diameter: 150,
                        color: Colors.white.withOpacity(.1),
                        scale: scaleCircle1.value,
                      ),
                    ),
                    Opacity(
                      opacity: opacityCircle2.value,
                      child: _buildCircle(
                        diameter: 150,
                        color: Colors.white.withOpacity(.1),
                        scale: scaleCircle2.value,
                      ),
                    ),
                    Opacity(
                      opacity: opacityCircle3.value,
                      child: _buildCircle(
                        diameter: 75,
                        color: Colors.white.withOpacity(0.2),
                        scale: scaleCircle3.value,
                      ),
                    ),
                  ],
                );
              },
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (playController.isCompleted) {
                    controller.stop();
                    playController.reverse();
                  } else {
                    controller.repeat();
                    playController.forward();
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: secondaryColor),
                  child: Center(
                    child: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      color: Colors.white,
                      progress: playController,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle({
    required double diameter,
    required Color color,
    required double scale,
  }) {
    return Center(
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }
}
