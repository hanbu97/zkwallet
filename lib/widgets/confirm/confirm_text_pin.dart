import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge_template/widgets/confirm/prompt_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/config/styles.dart';
import 'local_password.dart';
import 'main_button.dart';

Future<String?> confirmTextPin({
  String title = 'Confirm',
  String content = '是否确认',
  String textOK = 'OK',
  String textCancel = 'Cancel',
  String? hintText,
  String? initialValue,
  TextEditingController? controller,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
}) async {
  final out = await prompt(
    Get.context!,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24.w)),
      side: BorderSide(color: Styles.mainColorDark),
    ),
    decoration: InputDecoration(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Styles.mainColorDark),
      ),
    ),
    obscureText: true,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(24.w)),
    // ),
    showPasswordIcon: true,
    title: Center(
      child: Text(
        title,
        style: TextStyle(
            color: Styles.mainColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.w),
      ),
    ),
    initialValue: initialValue,
    isSelectedInitialValue: false,
    textOK: MainButtonContainer(
      width: 200.w,
      text: textOK,
    ),
    textCancel: MainButtonContainer(
      width: 60.w,
      isCancel: true,
    ),
    buttonPadding: EdgeInsets.symmetric(horizontal: 12.w),
    hintText: hintText,
    validator: validator,
    minLines: 1,
    maxLines: 1,
    autoFocus: true,
    barrierDismissible: true,
    textCapitalization: TextCapitalization.words,
    textAlign: TextAlign.start,
    controller: controller,
  );

  // if (out != null) {
  //   if (await verifyPin()) {
  //     return out;
  //   } else {
  //     return null;
  //   }
  // }
  return out;
}
