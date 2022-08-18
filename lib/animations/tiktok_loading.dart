import 'package:flutter/material.dart';
import 'package:flutter_microanimations/animations/style/colors.dart';

class TikTokLoading extends StatefulWidget {
  const TikTokLoading({Key? key}) : super(key: key);

  @override
  State<TikTokLoading> createState() => _TikTokLoadingState();
}

class _TikTokLoadingState extends State<TikTokLoading>
    with SingleTickerProviderStateMixin {
  Color tiktok1 = const Color(0xFFFE2D55);
  Color tiktok2 = const Color(0xFF1FDAEB);
  final animationDuration = const Duration(milliseconds: 700);

  late AnimationController controller;
  late Animation<double> scaleRedLeft;
  late Animation<double> scaleRedRight;

  late Animation<double> offsetRedLeft;
  late Animation<double> offsetRedRight;
  late Animation<double> offsetBlue;

  late Animation<double> scaleBlue;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: animationDuration,
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
    scaleRedRight = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(0.0),
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

    offsetBlue = Tween<double>(
      begin: 18,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    offsetRedLeft = Tween<double>(
      begin: 0,
      end: 9,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.linear),
      ),
    );
    offsetRedRight = Tween<double>(
      begin: 7,
      end: 18.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.linear),
      ),
    );

    controller.repeat(reverse: true);
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
          ],
        ),
      ),
    );
  }
}
