import 'package:flutter/material.dart';

class AnimatedPlayButton extends StatelessWidget {
  const AnimatedPlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const effectColor = Color(0xFFE54954);
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B26),
      body: Center(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  backgroundColor: effectColor.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    effectColor,
                  ),
                ),
              ),
            ),
            const Center(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.play_arrow,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
