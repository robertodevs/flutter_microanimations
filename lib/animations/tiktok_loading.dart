import 'package:flutter/material.dart';

class TikTokLoading extends StatefulWidget {
  const TikTokLoading({Key? key}) : super(key: key);

  @override
  State<TikTokLoading> createState() => _TikTokLoadingState();
}

class _TikTokLoadingState extends State<TikTokLoading> {
  double endDxOffset1 = 0.0;
  double endDxOffset2 = 20.0;

  double endScale2 = 0.7;
  Color tiktok1 = const Color(0xFFFE2D55);
  Color tiktok2 = const Color(0xFF1FDAEB);
  final animationDuration = const Duration(milliseconds: 350);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: endDxOffset2),
              onEnd: () => endDxOffset2 == 0.0
                  ? setState(
                      () => endDxOffset2 = 20.0,
                    )
                  : setState(
                      () => endDxOffset2 = 0.0,
                    ),
              duration: animationDuration,
              builder: (_, double value, ___) {
                return Transform.translate(
                    offset: Offset(value, 0),
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 1.0, end: endScale2),
                      curve: Curves.slowMiddle,
                      duration: animationDuration * 2,
                      onEnd: () => endScale2 == 0.7
                          ? setState(() => endScale2 = 1.0)
                          : setState(() => endScale2 = 0.7),
                      builder: (_, double value, __) {
                        return Transform.scale(
                          scale: value,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: tiktok2.withOpacity(0.8),
                          ),
                        );
                      },
                    ));
              },
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 20.0, end: endDxOffset1),
              onEnd: () => endDxOffset1 == 0.0
                  ? setState(() => endDxOffset1 = 20.0)
                  : setState(() => endDxOffset1 = 0.0),
              duration: animationDuration,
              builder: (_, double value, ___) {
                return Transform.translate(
                  offset: Offset(value, 0),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: tiktok1.withOpacity(0.8),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
