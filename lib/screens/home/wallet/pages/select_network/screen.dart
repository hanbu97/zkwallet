import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterspay/utils/config/styles.dart';
import 'package:waterspay/widgets/buttons/bg_button.dart';

class SelectNetworkPage extends StatefulWidget {
  const SelectNetworkPage({super.key});

  @override
  State<SelectNetworkPage> createState() => _SelectNetworkPageState();
}

class _SelectNetworkPageState extends State<SelectNetworkPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Select Network',
          style: TextStyle(color: Styles.mainColor),
        ),
        backgroundColor: Styles.backgroundColor,
        iconTheme: IconThemeData(color: Styles.mainColor),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "EDIT",
                style: TextStyle(
                    color: Styles.mainColor, fontWeight: FontWeight.w800),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Styles.backgroundColor,
          child: Container(
              margin: EdgeInsets.only(bottom: 12.w),
              padding: EdgeInsets.only(top: 10.w, left: 23.w, right: 23.w),
              // decoration: BoxDecoration(
              //     border: Border(
              //         top: BorderSide(width: 0.5.w, color: Styles.mainColor))),
              child: BgButton(
                text: 'Add Network'.tr,
                radius: 15.w,
              )

              // Container(
              //   child: TextButton(
              //     child: Text(
              //       'Add Network',
              //       style: Styles.contentWhite,
              //     ),
              //     onPressed: () {},
              //   ),
              // ),
              )

          // Column(
          //   children: [
          //     Divider(
          //       thickness: 0.5.w,
          //       color: Styles.mainColor,
          //     )
          //   ],
          // )

          // Container(
          //   height: 60,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       TextButton(
          //           onPressed: () {},
          //           child: Text(
          //             "ADD NETWORK",
          //             style: TextStyle(
          //                 color: Styles.mainColor, fontWeight: FontWeight.w800),
          //           )),
          //       TextButton(
          //           onPressed: () {},
          //           child: Text(
          //             "DONE",
          //             style: TextStyle(
          //                 color: Styles.mainColor, fontWeight: FontWeight.w800),
          //           ))
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
