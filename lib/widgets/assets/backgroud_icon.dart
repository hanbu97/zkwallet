import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rust_bridge_template/utils/config/styles.dart';

class BackgroundIcon extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color backgroundColor;
  final double padding;
  final double? size;

  BackgroundIcon({
    required this.iconData,
    required this.iconColor,
    required this.backgroundColor,
    required this.padding,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double defaultSize = constraints.maxWidth;
        final double iconSize = size ?? defaultSize - padding * 2;
        return FittedBox(
          fit: BoxFit.contain,
          child: Container(
            width: size == null ? size ?? 0 * 2 : defaultSize,
            height: size == null ? size ?? 0 * 2 : defaultSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Icon(
                iconData,
                size: iconSize,
                color: iconColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

class RoundIcon extends StatelessWidget {
  IconData icon;
  final Color backgroundColor;
  Color iconColor;
  final Color borderColor;
  final double size;
  final double borderWidth;
  double padding;
  RoundIcon(
      {Key? key,
      required this.icon,
      required this.iconColor,
      required this.backgroundColor,
      this.borderColor = Colors.white,
      this.size = 20.0,
      this.padding = 0,
      this.borderWidth = 2.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 1.5,
      height: size * 1.5,
      decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
      child: Icon(
        icon,
        color: iconColor,
        size: size - padding,
      ),
    );
  }
}
