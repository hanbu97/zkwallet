import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/config/styles.dart';

class BgButton extends StatelessWidget {
  const BgButton({super.key, required this.text, this.onPressed, this.radius});

  final String text;
  final double? radius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink(
        height: 50.w,
        decoration: BoxDecoration(
          color: const Color(0xff023327),
          borderRadius: BorderRadius.circular(radius ?? 6.w),
          border: Border.all(
            color: Styles.mainColorDark,
            width: 1.w,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Styles.mainColor,
                fontSize: 16.w,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      onTap: () async {},
    );
  }
}
