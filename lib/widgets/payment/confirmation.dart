// import 'package:falafi/screens/shared/widgets/prettyjson.dart';
// import 'package:falafi/screens/shared/widgets/verify_password.dart';
// import 'package:falafi/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rust_bridge_template/utils/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuple/tuple.dart';

import 'prettyjson.dart';
import 'verify_password.dart';

List<Widget> _getItems(
  Map<String, String> content,
) {
  print(content);

  List<Widget> out = [];
  content.forEach((key, value) {
    out.add(Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    key,
                    // textBaseline: TextBaseline.alphabetic,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )),
              ),
              Expanded(
                flex: 16,
                child: Container(
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Divider(
          color: Colors.blueGrey,
          thickness: 1,
        ),
        const SizedBox(height: 20),
      ],
    ));
  });

  return out;
}

void showConfirmationDialog(
    String address,
    String name,
    String? title,
    Tuple2<Map<String, Object?>, String> msg,
    Map<String, String> content,
    BuildContext context,
    {Map<String, Object>? addt}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Confirmation Details"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Styles.backgroundColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            // height: 1100,
            child: Column(
              children: [
                title != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 30, color: Colors.black),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 8),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                ..._getItems(content),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                  child: PrettyJsonText(data: msg.item1),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                // primary: Colors.black,
                minimumSize: const Size.fromHeight(50), // NEW
                backgroundColor: Styles.backgroundColor),
            onPressed: () {
              _showVerifyPasswordDialog(name, address, msg, context,
                  addt: addt);
            },
            child: const Text(
              'Confirm',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      );
    },
  );
}

void _showVerifyPasswordDialog(String name, String address,
    Tuple2<Map<String, Object?>, String> msg, BuildContext context,
    {Map<String, Object>? addt}) {
  showDialog(
    context: context,
    builder: (context) {
      return VerifyPassword(
        name: name,
        address: address,
        msg: msg,
        isOffline: false,
        context: context,
        addt: addt,
      );
    },
  );
}

void showVerifyPasswordDialogOffline(
    String name, String address, String msg, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return VerifyPassword(
        name: name,
        address: address,
        msg: Tuple2({}, msg),
        isOffline: true,
        context: context,
      );
    },
  );
}
