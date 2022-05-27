import 'package:flutter/material.dart';
import 'package:flutter_microanimations/animations/style/colors.dart';

class AirbnbLoadingAnimation extends StatefulWidget {
  const AirbnbLoadingAnimation({Key? key}) : super(key: key);

  @override
  State<AirbnbLoadingAnimation> createState() => _AirbnbLoadingAnimationState();
}

class _AirbnbLoadingAnimationState extends State<AirbnbLoadingAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> firstCircle;
  late Animation<double> secondCircle;
  late Animation<double> thirdCircle;
  late Animation<double> opacity;

  double begin = 0;
  double end = 5;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    firstCircle = getOffsetAnimation(0.0, 0.4);
    secondCircle = getOffsetAnimation(0.2, 0.6);
    thirdCircle = getOffsetAnimation(0.4, 0.8);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.1, 1.0, curve: Curves.easeIn),
      ),
    );
    controller.repeat();
    super.initState();
  }

  Animation<double> getOffsetAnimation(double lowLimit, double upperLimit) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(lowLimit, upperLimit, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: controller.view,
              builder: (BuildContext context, _) {
                return Opacity(
                  opacity: opacity.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCircle(firstCircle.value),
                      const SizedBox(
                        width: 4,
                      ),
                      _buildCircle(secondCircle.value),
                      const SizedBox(
                        width: 4,
                      ),
                      _buildCircle(thirdCircle.value),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'LOADING',
            style: TextStyle(color: Colors.white, fontSize: 10),
          )
        ],
      ),
    );
  }

  Widget _buildCircle(double verticalPosition) {
    return Transform.translate(
      offset: Offset(0, verticalPosition),
      child: Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}
