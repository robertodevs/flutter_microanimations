import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FigmaToLottie extends StatefulWidget {
  const FigmaToLottie({Key? key}) : super(key: key);

  @override
  State<FigmaToLottie> createState() => _FigmaToLottieState();
}

class _FigmaToLottieState extends State<FigmaToLottie>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 1000,
        ));
    if (_controller.isCompleted) {
      Navigator.of(context).pop();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          iconSize: 150,
          splashRadius: 32,
          onPressed: () {
            _controller.forward();
            if (_controller.isCompleted) {
              _controller.reset();
            }
          },
          icon: Lottie.asset(
            'assets/animations/youtube-like.json',
            repeat: false,
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
