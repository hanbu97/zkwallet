// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// Future<bool> verifyPin() async {
//   final TextEditingController pinController = TextEditingController();
//   bool pinIsCorrect = false;

//   final pinCode = await DataSpa.getLocalPwd();

//   if (pinCode == null) {
//     Get.snackbar('错误', '请先设置验证密码');

//     Get.to(() => const LocalPasswdScreen());
//     return false;
//   }

//   await Get.defaultDialog(
//     title: '请输入验证密码',
//     backgroundColor: Styles.backgroundColor,
//     titlePadding: EdgeInsets.symmetric(vertical: 66.w),
//     titleStyle: TextStyle(
//         fontSize: 52.w, fontWeight: FontWeight.w600, color: Styles.mainColor),
//     content: Form(
//       child: PinCodeTextField(
//         appContext: Get.context!,
//         length: 6,
//         obscureText: true,
//         autoFocus: true,
//         keyboardType: TextInputType.number,
//         controller: pinController,
//         onChanged: (value) {},
//         onCompleted: (value) {
//           if (pinCode == value) {
//             pinIsCorrect = true;
//             Get.back();
//           } else {
//             EasyLoading.showError('请输入正确的验证密码');
//             pinController.clear();
//             Get.snackbar('错误', '请输入正确的验证密码');
//             Get.back();
//           }
//         },
//         pinTheme: PinTheme(
//             shape: PinCodeFieldShape.circle,
//             selectedColor: Colors.blue,
//             inactiveColor: const Color(0xff95DBDF),
//             disabledColor: const Color(0xff95DBDF)),
//       ),
//     ),
//     // confirm: TextButton(
//     //   onPressed: () {
//     //     if (pinIsCorrect) {
//     //       Get.back();
//     //     } else {
//     //       Get.snackbar('错误', '请输入正确的验证密码');
//     //     }
//     //   },
//     //   child: const Text('确认'),
//     // ),
//   );

//   return pinIsCorrect;
// }
