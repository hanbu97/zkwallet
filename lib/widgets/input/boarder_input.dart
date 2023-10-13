import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/config/styles.dart';

class BoarderInput extends StatelessWidget {
  BoarderInput(
      {super.key,
      required this.controller,
      this.hintText,
      this.leading = const [],
      this.actions = const []});

  TextEditingController controller;
  final String? hintText;
  final List<Widget> actions;
  final List<Widget> leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Styles.mainColor),
          borderRadius: BorderRadius.circular(12.w)),
      padding: EdgeInsets.only(left: 15.w),
      child: Row(
        children: [
          ...leading,
          leading.isNotEmpty
              ? SizedBox(
                  width: 8.w,
                )
              : const SizedBox(),
          Expanded(
              child: TextField(
            controller: controller,
            style: TextStyle(
              color: Styles.titleColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Styles.infoGrayColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: const EdgeInsets.only(),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          )),
          ...actions
        ],
      ),
    );
  }
}
