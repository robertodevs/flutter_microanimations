import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({Key? key}) : super(key: key);

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  final primaryColor = const Color(0xFF48C0B2);

  double heigthCircle1 = 30;
  double heigthCircle2 = 30;

  double yPositionCircle1 = 5;
  double yPositionCircle2 = 40;

  bool isUp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF75FDEC),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            if (isUp) {
              setState(
                () {
                  heigthCircle1 = 70;
                  yPositionCircle1 = 40;
                  yPositionCircle2 = 5;
                  isUp = !isUp;
                },
              );
              await Future.delayed(const Duration(milliseconds: 300));
              setState(() {
                heigthCircle1 = 30;
              });
            } else {
              setState(
                () {
                  heigthCircle2 = 70;
                  yPositionCircle2 = 40;
                  yPositionCircle1 = 5;
                  isUp = !isUp;
                },
              );
              await Future.delayed(const Duration(milliseconds: 300));
              setState(() {
                heigthCircle2 = 30;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            width: 300,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  _buildToggles(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Android',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'iOS',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggles() {
    return Column(
      children: [
        Stack(
          children: [
            const SizedBox(
              height: 100,
              width: 40,
            ),
            _buildAndroidCircle(),
            _buildiOSCircle(),
          ],
        ),
      ],
    );
  }

  Widget _buildiOSCircle() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 600),
      top: yPositionCircle2,
      curve: Curves.easeInBack,
      child: GestureDetector(
        child: AnimatedContainer(
          width: 30,
          height: heigthCircle2,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: const Color(0xffD7EDE9),
          ),
        ),
      ),
    );
  }

  Widget _buildAndroidCircle() {
    return AnimatedPositioned(
      top: yPositionCircle1,
      curve: Curves.easeInBack,
      duration: const Duration(milliseconds: 600),
      child: GestureDetector(
        child: AnimatedContainer(
          width: 30,
          height: heigthCircle1,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
