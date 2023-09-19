import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge_template/utils/config/images.dart';
import 'package:flutter_rust_bridge_template/utils/extension/custom_ext.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/config/styles.dart';

class WalletPage extends StatelessWidget {
  WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      appBar: AppBar(
        backgroundColor: Styles.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Container(
              // height: 32.h,
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
              decoration: BoxDecoration(
                  color: const Color(0xff263530),
                  borderRadius: BorderRadius.circular(20.w)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Gshock-okk',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xffE0E6E4),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.swap_horiz,
                    color: const Color(0xffE0E6E4),
                    // color: Styles.backgroundColor,
                    size: 16.w,
                  )
                ],
              ),
            ),
          ],
        ),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/icons/eth.png',
                width: 16.w,
                height: 16.w,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text('VARA',
                  style: GoogleFonts.titilliumWeb(
                      fontSize: 14.sp,
                      color: Styles.titleColor,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(
            width: 10.w,
          ),
          Container(
            width: 39.w,
            height: 39.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2.0, // you can adjust the width as you need
              ),
            ),
            child: ClipOval(
                child: ImageRes.zkLogo.toImage
                  ..width = 39.w
                  ..height = 39.w),
          ),
          SizedBox(
            width: 12.w,
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.w,
            ),
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  width: mq.size.width,
                  margin: EdgeInsets.only(bottom: 22.w),
                  height: 145.w,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(2, 86, 255, 0.6),
                          Styles.mainColor,
                        ],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(2, 2), //x,y轴
                          color: Color.fromRGBO(82, 119, 172, 0.6), //投影颜色
                          blurRadius: 2, //投影距离
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 21.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total Available Balance',
                                    style: GoogleFonts.titilliumWeb(
                                      color: Styles.mainWhite,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Image.asset(
                                    "assets/images/icons/eye_open.png",
                                    width: 15.w,
                                    height: 15.w,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 21.w),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '\$ 12,3455.00',
                            style: GoogleFonts.titilliumWeb(
                              fontSize: 32.sp,
                              color: Styles.mainWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 102.w,
                    child: Container(
                        width: 280.w,
                        height: 65.w,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.w),
                            // color: Styles.mainColorDark,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(2, 2), //x,y轴
                                color: Color.fromRGBO(82, 119, 172, 0.6), //投影颜色
                                blurRadius: 2, //投影距离
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 48.w,
                                width: 48.w,
                                padding: EdgeInsets.all(11.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.w),
                                  color: Styles.mainColorDark,
                                ),
                                child: Icon(
                                  Icons.download,
                                  color: Colors.white,
                                  size: 22.w,
                                ),
                              ),
                              Container(
                                height: 48.w,
                                width: 48.w,
                                padding: EdgeInsets.all(11.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.w),
                                  color: Styles.mainColorDark,
                                ),
                                child: Icon(
                                  Icons.upload,
                                  color: Colors.white,
                                  size: 22.w,
                                ),
                              ),
                              Container(
                                height: 48.w,
                                width: 48.w,
                                padding: EdgeInsets.all(11.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.w),
                                  color: Styles.mainColorDark,
                                ),
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                  size: 22.w,
                                ),
                              ),
                              Container(
                                height: 48.w,
                                width: 48.w,
                                padding: EdgeInsets.all(11.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.w),
                                  color: Styles.mainColorDark,
                                ),
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.white,
                                  size: 22.w,
                                ),
                              )
                            ],
                          ),
                        )))
              ],
            ),
            Column(children: [
              MenuItem(
                name: 'Reset Password',
                logo: 'assets/images/menu/pwd.png',
                routeName: '',
              ),
              MenuItem(
                name: 'Preferences',
                logo: 'assets/images/menu/setting.png',
                routeName: '',
              ),
              MenuItem(
                name: 'Collection',
                logo: 'assets/images/menu/collection.png',
                routeName: '',
              ),
              MenuItem(
                name: 'Help',
                logo: 'assets/images/menu/help.png',
                routeName: '',
              ),
              MenuItem(
                name: 'About',
                logo: 'assets/images/menu/about.png',
                routeName: '',
              )
            ]),

            // Stack(
            //   children: [
            //     // 按钮列表
            //     Container(
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(39.r),
            //             topRight: Radius.circular(39.r),
            //           ),
            //           color: Styles.white),
            //       margin: EdgeInsets.only(top: 177.w),
            //       padding: EdgeInsets.only(top: 83.w),
            //       child: ListView(
            //         physics: ClampingScrollPhysics(),
            //         padding: EdgeInsets.fromLTRB(31.w, 0, 25.w, 0),

            //         ],
            //       ),
            //     ),

            //   ],
            // )
            SizedBox(
              height: 40.w,
            ),
            // Center(
            //   child: Container(
            //     alignment: Alignment.center,
            //     width: double.infinity,
            //     height: 42.h,
            //     child: ConfirmButton(
            //       cancel: true,
            //       click: () => {
            //         // Get.back(),
            //         // Get.toNamed("/exportTip"),
            //         // print(1111)
            //         // Get.to(() => SyncTgScreen())

            //         // _client?.send(tdApi.LogOut());
            //         DataSp.tgStateManager.logout(),
            //       },
            //       text: Text(
            //         'Log out',
            //         style: TextStyle(
            //           color: Styles.mainColor,
            //           fontSize: 16.sp,
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 30.w,
            ),
          ],
        ),
      )),
    );
  }
}

// 操作按钮组件
class MenuItem extends StatelessWidget {
  const MenuItem({Key? key, this.name, this.logo, this.routeName})
      : super(key: key);
  final name; // 名称
  final logo; // logo
  final routeName; // 路由跳转地址
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Get.toNamed(routeName),
        child: Container(
          margin: EdgeInsets.only(top: 36.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 12.w,
              ),
              Image.asset(
                logo,
                width: 24.w,
                height: 24.w,
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: Text(name,
                    style: GoogleFonts.rubik(
                      color: Styles.titleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    )

                    // TextStyle(
                    //   color: Styles.titleColor,
                    //   fontSize: 14.sp,
                    //   fontWeight: FontWeight.w600,
                    // ),
                    ),
              ),
              Image.asset(
                "assets/images/icons/arrow_right.png",
                width: 24.w,
                height: 24.w,
              ),
            ],
          ),
        ));
  }
}
