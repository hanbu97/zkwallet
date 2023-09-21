import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/config/styles.dart';
// import 'package:makeupyoungemployee/utils/config/styles.dart';

class MainButton extends StatelessWidget {
  MainButton(
      {super.key,
      required this.onPressed,
      this.widget,
      this.darkColor,
      this.lightColor,
      this.text,
      this.width,
      this.height,
      this.isCancel = false,
      this.radius});

  final Color? darkColor;
  final Color? lightColor;
  final double? radius;
  final bool isCancel;

  final double? width;
  final double? height;

  final Widget? widget;
  final String? text;

  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: isCancel
          ? ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      side: BorderSide(
                          color: Styles.mainColor, width: 1), // 这里设置边框颜色和宽度
                      borderRadius:
                          BorderRadius.circular(radius ?? 9.w), // 这里设置边框圆角
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Styles.mainColorDark)),
              onPressed: onPressed,
              child: Container(
                decoration: BoxDecoration(
                  color: Styles.mainColorDark,
                ),
                child: Center(
                  child: widget ??
                      Icon(
                        Icons.close,
                        weight: 0.6,
                        color: Colors.black,
                      ),
                ),
              ))
          : ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(radius ?? 9.w), // 这里设置边框圆角
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(darkColor ?? Styles.mainColor)),
              onPressed: onPressed,
              child: Center(
                child: widget ??
                    Text(
                      text ?? 'OK',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
              )),
    );
  }
}

class MainButtonContainer extends StatelessWidget {
  MainButtonContainer(
      {this.widget,
      this.darkColor,
      this.lightColor,
      this.isCancel = false,
      this.radius,
      this.width,
      this.text});

  final Color? darkColor;
  final Color? lightColor;
  final double? radius;
  final bool isCancel;

  final Widget? widget;
  final String? text;

  final double? width;

  @override
  Widget build(BuildContext context) {
    return isCancel
        ? Container(
            width: width,
            height: 36.w,
            // padding: EdgeInsets.all(7.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 9.w),
              border: Border.all(color: Styles.mainColor, width: 1),
              color: Styles.mainColorDark,
            ),
            child: Center(
              child: widget ??
                  Icon(
                    Icons.close,
                    size: 20.sp,
                    color: Styles.backgroundColor,
                  ),
            ),
          )
        : Container(
            width: width,
            height: 36.w,
            padding: EdgeInsets.all(7.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 9.w),
                color: Styles.backgroundColor,
                border: Border.all(color: Styles.mainColor)),
            child: Center(
              child: widget ??
                  Text(
                    text ?? 'OK',
                    style: TextStyle(
                      color: Styles.mainColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ),
          );
  }
}
