import 'package:flutter/material.dart';

class AnimatedScrollCard extends StatefulWidget {
  const AnimatedScrollCard({
    Key? key,
    required this.child,
    this.keepAlive = false,
  }) : super(key: key);

  final Widget child;
  final bool keepAlive;

  @override
  State<AnimatedScrollCard> createState() => _AnimatedScrollCardState();
}

class _AnimatedScrollCardState extends State<AnimatedScrollCard>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController controller;
  late Animation<double> turns;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();

    turns = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1, curve: Curves.easeInOutBack),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RotationTransition(
      turns: turns,
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
