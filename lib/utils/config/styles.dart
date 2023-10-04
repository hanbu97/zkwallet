import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  Styles._();

  // params
  static double paramsContentPadding = 19.w;
  static double paramsSmallSpacerV = 12.w;

  static Color mainWhite = const Color(0xFFFFFFFF);
  static Color buttonBackground = const Color(0xff1A1A1A);
  static Color backgroundColor = Colors.black;
  // static Color contentBackground = const Color(0xff263530);
  static Color contentColor = const Color(0xffE0E6E4);
  static Color contentBackground = const Color(0xFF303033);

  static Color mainColor = const Color(0xFF00FFC4);
  static Color mainColorDark = const Color(0xff00AA83);

  static Color mainInactive = const Color(0xff1F1F1F);

  static Color titleColor = const Color(0xFF00FFC4);
  static Color infoGrayColor = Styles.mainWhite.withOpacity(0.8);

  static Color appbgcolor = const Color(0xFFF6F6F6); // 页面背景色
  static Color warinBgcolor = const Color(0xFFFAE5E7); // 警告背景色
  static Color warinTextcolor = const Color(0xFFE7573E); // 警告字体颜色
  static Color themeBgcolor = const Color(0xFFE0F1FF); // 主题色背景
  static Color themeTextcolor = const Color(0xFF0089FF); // 主题色字体
  static Color blackTextcolor = const Color(0xFF232323); // 黑色字颜色
  static Color graycolor = const Color(0xFF8C8C8C); // 灰色1号
  static Color graycolor1 = const Color(0xFFF2F1F6); // 灰色2号

  // font stlyes
  static TextStyle contentWhite = GoogleFonts.rubik(
    color: mainWhite,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle contentWhiteSmall = GoogleFonts.rubik(
    color: mainWhite,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle contentmainDarkSmall = GoogleFonts.rubik(
    color: infoGrayColor,
    fontSize: 12.sp,
    // fontWeight: FontWeight.w600,
  );

  static Widget contentPadding({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paramsContentPadding),
      child: child,
    );
  }

  static Widget lineSpacerV() {
    return SizedBox(
      height: 2.w,
    );
  }

  static Widget smallSpacerV() {
    return SizedBox(
      height: paramsSmallSpacerV,
    );
  }

  static Widget expandedSpacerV() {
    return const Expanded(
      child: SizedBox(),
    );
  }
}
