import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExplicitAnimation extends StatefulWidget {
  const ExplicitAnimation({Key? key}) : super(key: key);

  @override
  State<ExplicitAnimation> createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> position;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
    );

    position = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.isCompleted) {
            controller.reset();
          } else {
            controller.forward();
          }
        },
        backgroundColor: Colors.black,
        child: const Icon(FontAwesomeIcons.play),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: controller.view,
            builder: ((context, child) => Transform.translate(
                  offset: Offset(0, position.value),
                  child: child,
                )),
            child: const Center(
              child: Icon(
                FontAwesomeIcons.basketball,
                size: 100,
              ),
            ),
          )
        ],
      ),
    );
  }
}
