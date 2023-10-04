import 'dart:math' as math;
import 'package:flutter/material.dart';

Widget topLeftWidget(double screenWidth) {
  return Transform.rotate(
    angle: -35 * math.pi / 180,
    child: Transform.scale(
      scale: 2,
      alignment: Alignment.centerLeft,
      child: Container(
        width: 0.4 * screenWidth,
        height: 0.4 * screenWidth,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(150, 255, 255, 255), width: 1),
          borderRadius: BorderRadius.circular(200),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment(-0.2, 1),
            colors: [
              // Colors.green, // End color
              Colors.white,
              Color.fromARGB(188, 128, 211, 131),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget topWidget(double screenWidth) {
  return Transform.rotate(
    angle: -35 * math.pi / 180,
    child: Container(
      width: 1.2 * screenWidth,
      height: 1.2 * screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(450),
        gradient: const LinearGradient(
          begin: Alignment(-0.2, -0.8),
          end: Alignment(-0.2, 1),
          colors: [
            Color(0x007CBFCF),
            Color(0xB316BFC4),
          ],
        ),
      ),
    ),
  );
}

Widget bottomRightWidget(double screenWidth) {
  return Transform.rotate(
    angle: -0 * math.pi / 180,
    child: Transform.scale(
      scaleX: 2,
      scaleY: 1.3,
      alignment: Alignment.centerLeft,
      child: Container(
        width: 0.4 * screenWidth,
        height: 0.4 * screenWidth,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(150, 255, 255, 255), width: 1),
          borderRadius: BorderRadius.circular(200),
          gradient: const LinearGradient(
            begin: Alignment(-1, -0),
            end: Alignment(1, 0),
            colors: [
              // Colors.green, // End color
              Color.fromARGB(188, 128, 211, 131),
              Colors.white,
            ],
          ),
        ),
      ),
    ),
  );
}

class ProfileDecoration extends StatelessWidget {
  const ProfileDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: -0.23 * screenSize.height,
          left: -50,
          child: topWidget(screenSize.width),
        ),
        Positioned(
          left: -0.32 * screenSize.width,
          top: -0.05 * screenSize.height,
          child: topLeftWidget(screenSize.width),
        ),
        Positioned(
          left: 0.65 * screenSize.width,
          top: 0.15 * screenSize.height,
          child: bottomRightWidget(screenSize.width),
        ),
      ],
    );
  }
}
