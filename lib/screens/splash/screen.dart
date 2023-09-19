import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge_template/utils/extension/custom_ext.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:openim_common/openim_common.dart';

import '../../utils/config/images.dart';
import 'logic.dart';

class Circle {
  final double size;
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final Color color;

  Circle({
    required this.size,
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.color,
  });
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.find<SplashLogic>();

  late AnimationController _controller;

  final circles = [
    Circle(
        size: 10.w,
        startX: 187.5.w,
        startY: 320.w,
        endX: 88.w,
        endY: 282.w,
        color: const Color(0xFF0556FF).withAlpha(77)),
    Circle(
        size: 15.w,
        startX: 187.5.w,
        startY: 320.w,
        endX: 100.w,
        endY: 338.w,
        color: const Color(0xFF0556FF)),
    Circle(
        size: 13.w,
        startX: 187.5.w,
        startY: 320.w,
        endX: 265.w,
        endY: 360.w,
        color: const Color(0xFF0556FF).withAlpha(153)),
    Circle(
        size: 5.w,
        startX: 187.5.w,
        startY: 310.w,
        endX: 265.w,
        endY: 250.w,
        color: const Color(0xFF0556FF).withAlpha(179)),
    Circle(
        size: 10.w,
        startX: 187.5.w,
        startY: 310.w,
        endX: 230.w,
        endY: 205.w,
        color: const Color(0xFF0556FF).withAlpha(64)),
    Circle(
        size: 10.w,
        startX: 167.5.w,
        startY: 265.w,
        endX: 125.w,
        endY: 225.w,
        color: const Color(0xFF0556FF).withAlpha(128)),
  ];
  List<Animation<double>> animationsX = [];
  List<Animation<double>> animationsY = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    for (var circle in circles) {
      animationsX.add(Tween<double>(
        begin: circle.startX,
        end: circle.endX,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      )));

      animationsY.add(Tween<double>(
        begin: circle.startY,
        end: circle.endY,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      )));
    }

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: Stack(
        children: [
          ...circles.asMap().entries.map((entry) {
            var circle = entry.value;
            var index = entry.key;
            return AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return Positioned(
                  left: animationsX[index].value,
                  top: animationsY[index].value,
                  child: Container(
                    width: circle.size,
                    height: circle.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: circle.color,
                    ),
                  ),
                );
              },
            );
          }).toList(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 207.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageRes.splashLogo.toImage..width = 188.05.w
                  // ..height = 78.91.h,
                ],
              ),
              SizedBox(height: 15.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageRes.splashToplink.toImage..width = 161.w
                  // ..height = 78.91.h,
                ],
              ),
              SizedBox(
                height: (mq.size.height) / 2 - 210.w,
              ),
              _controller.isAnimating
                  ? GFLoader(
                      type: GFLoaderType.android,
                      androidLoaderColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF0556FF)),
                      size: 35.w,
                    )
                  : const SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
