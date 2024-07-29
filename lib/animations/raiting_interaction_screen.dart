import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RaitingInteractionScreen extends StatefulWidget {
  const RaitingInteractionScreen({Key? key}) : super(key: key);

  @override
  State<RaitingInteractionScreen> createState() =>
      _RaitingInteractionScreenState();
}

class _RaitingInteractionScreenState extends State<RaitingInteractionScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  List<Color> colors = [
    const Color(0xFFFF4A4F),
    const Color(0xFFFE9160),
    const Color(0xFF7502FF),
    const Color(0xFF7395FF),
    const Color(0xFF84E257)
  ];
  List<AnimationController> controllers = [];
  List<Animation<double>> scales = [];

  List<String> lotties = [
    'assets/animations/angry.json',
    'assets/animations/sad.json',
    'assets/animations/doubt.json',
    'assets/animations/happy.json',
    'assets/animations/superHappy.json',
  ];

  int currentPage = 0;
  Color currentBackgroundColor = Colors.white;
  static const int kAnimationDuration = 400;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: kAnimationDuration),
    );

    controllers.add(controller);
    controllers.add(controller);
    controllers.add(controller);
    controllers.add(controller);
    controllers.add(controller);

    for (var i = 0; i < 5; i++) {
      scale = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controllers[i],
          curve: const Interval(.5, 1, curve: Curves.easeOutBack),
        ),
      );
      scales.add(scale);
    }
    controllers[0].forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentBackgroundColor,
      body: GestureDetector(
        onHorizontalDragEnd: onDragInteraction,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildBackgroundAnimation(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTitle(),
                const SizedBox(height: 50),
                _buildEmojiAnimation(),
                const SizedBox(height: 50),
                _buildDotsIndicator(),
                const SizedBox(height: 100),
                _buildMainButton()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDotsIndicator() {
    return DotsIndicator(
      dotsCount: 5,
      position: currentPage.toDouble(),
      decorator: DotsDecorator(
        activeColor: Colors.white,
        color: Colors.grey.withOpacity(.5),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Rate your \nexperience',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
    );
  }

  Widget _buildBackgroundAnimation() {
    return AnimatedBuilder(
      animation: controllers[currentPage].view,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scale: controllers[currentPage].value * 2.5,
          child: Container(
            height: MediaQuery.of(context).size.height * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors[currentPage],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmojiAnimation() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: controllers[currentPage].view,
            builder: (BuildContext context, _) {
              return Transform.scale(
                scale: scales[currentPage].value,
                child: Lottie.asset(
                  lotties[currentPage],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMainButton() {
    return SizedBox(
      height: 60,
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {},
        child: const Text('Send Raiting'),
      ),
    );
  }

  void onDragInteraction(details) {
    if (details.primaryVelocity == null) return;
    if (details.primaryVelocity! < 0) {
      // drag from right to left
      if (currentPage < 4) {
        setState(() {
          currentPage++;
          currentBackgroundColor = colors[currentPage - 1];
        });
        controllers[currentPage - 1].reset();
        controllers[currentPage].forward(from: 0);
      }
    } else {
      if (currentPage > 0) {
        setState(() {
          currentPage--;
          currentBackgroundColor = colors[currentPage + 1];
        });
        controllers[currentPage].forward(from: 0);
        //controllers[currentPage + 1].reset();
      }
    }
  }
}
