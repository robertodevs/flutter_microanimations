import 'package:flutter/material.dart';
import 'package:flutter_microanimations/animations/animated_scroll/components/animated_scroll_card.dart';

class AnimatedScrollScreen extends StatelessWidget {
  const AnimatedScrollScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        cacheExtent: 0,
        itemCount: 8,
        itemBuilder: (context, index) {
          return AnimatedScrollCard(
            child: Card(
              elevation: 0,
              child: Column(
                children: [
                  Image.asset(
                    'assets/food0${index + 1}.png',
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Aji Sushi',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text('\$0 Delivery Fee . 35-45 min',
                            style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
