import 'package:flutter/material.dart';
import 'package:flutter_microanimations/animations/components/tween_wave.dart';
import 'package:flutter_microanimations/animations/style/colors.dart';

class MusicWave extends StatefulWidget {
  const MusicWave({Key? key}) : super(key: key);

  @override
  State<MusicWave> createState() => _MusicWaveState();
}

class _MusicWaveState extends State<MusicWave> {
  double bar1Scale = 1.0;
  double bar2Scale = 1.0;
  double bar3Scale = 1.0;
  double bar4Scale = 1.0;

  double barHeight1 = 60;
  double barHeight2 = 40;
  double barHeight3 = 40;
  double barHeight4 = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenWave(
              barScale: bar1Scale,
              barHeight: barHeight1,
              updateScale: (newScale) => setState(() => bar1Scale = newScale),
              waveDuration: 550,
            ),
            TweenWave(
              barScale: bar2Scale,
              barHeight: barHeight2,
              updateScale: (newScale) => setState(() => bar2Scale = newScale),
              waveDuration: 275,
            ),
            TweenWave(
              barScale: bar3Scale,
              barHeight: barHeight3,
              updateScale: (newScale) => setState(() => bar3Scale = newScale),
              waveDuration: 413,
            ),
            TweenWave(
              barScale: bar4Scale,
              barHeight: barHeight4,
              updateScale: (newScale) => setState(() => bar4Scale = newScale),
              waveDuration: 275,
            ),
          ],
        ),
      ),
    );
  }
}
