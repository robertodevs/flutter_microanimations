import 'package:flutter/material.dart';

class TikTokAnimation extends StatefulWidget {
  const TikTokAnimation({Key? key}) : super(key: key);

  @override
  State<TikTokAnimation> createState() => _TikTokAnimationState();
}

class _TikTokAnimationState extends State<TikTokAnimation>
    with SingleTickerProviderStateMixin {
  Color tiktok1 = const Color(0xFFFE2D55);

  Color tiktok2 = const Color(0xFF1FDAEB);

  late AnimationController controller;
  late Animation<double> scaleBlue;
  late Animation<double> offsetBlue;

  late Animation<double> scaleRedLeft;
  late Animation<double> offsetRedLeft;

  late Animation<double> scaleRedRight;
  late Animation<double> offsetRedRight;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    scaleBlue = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 1.0,
            end: .9,
          ).chain(
            CurveTween(curve: Curves.easeIn),
          ),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: .9,
            end: 1.0,
          ).chain(
            CurveTween(curve: Curves.easeOut),
          ),
          weight: 50.0,
        ),
      ],
    ).animate(controller);

    scaleRedLeft = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 1.1,
            end: 1.0,
          ).chain(
            CurveTween(curve: Curves.linear),
          ),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(0),
          weight: 50.0,
        ),
      ],
    ).animate(controller);

    offsetRedLeft = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );

    offsetBlue = Tween<double>(
      begin: 18,
      end: 0,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );

    scaleRedRight = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(0),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 1.0,
            end: 1.1,
          ).chain(
            CurveTween(curve: Curves.linear),
          ),
          weight: 50.0,
        ),
      ],
    ).animate(controller);

    offsetRedRight = Tween<double>(
      begin: 8,
      end: 18,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );

    offsetBlue = Tween<double>(
      begin: 18,
      end: 0,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );

    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: AnimatedBuilder(
        animation: controller.view,
        builder: (context, _) {
          return Stack(
            children: [
              Transform.translate(
                offset: Offset(offsetRedLeft.value, 0),
                child: Transform.scale(
                  scale: scaleRedLeft.value,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: tiktok1,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(offsetBlue.value, 0),
                child: Transform.scale(
                  scale: scaleBlue.value,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: tiktok2,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(offsetRedRight.value, 0),
                child: Transform.scale(
                  scale: scaleRedRight.value,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: tiktok1,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ));
  }
}
