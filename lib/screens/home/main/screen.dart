import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge_template/screens/home/wallet/screen.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/config/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tabIndex = 0.obs;
  final _bottomBarController = BottomBarWithSheetController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      body: Obx(
        () => IndexedStack(
          index: tabIndex.value,
          // children: [ChatsPage(), EventsPage(), DiscoverPage(), MenuPage()],
          children: [
            WalletPage(),
            Container(),
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xff1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.w)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: 10.w,
              left: 10.w,
              right: 10.w,
              bottom: mq.padding.bottom < 10.w ? 10.w : mq.padding.bottom),
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => tabIndex.value = 0,
                    child: Icon(
                      Icons.account_balance_wallet_sharp,
                      color: tabIndex.value == 0
                          ? Styles.mainColor
                          : Styles.infoGrayColor,
                      size: 30.w,
                    ),
                  ),
                  ExpandTapWidget(
                    tapPadding: EdgeInsets.all(20.w),
                    onTap: () => tabIndex.value = 1,
                    child: Icon(
                      Icons.image_outlined,
                      color: tabIndex.value == 1
                          ? Styles.mainColor
                          : Styles.infoGrayColor,
                      size: 30.w,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => tabIndex.value = 2,
                    onLongPress: () => {
                      // Get.to(() => const ScheduleSearch())
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color: tabIndex.value == 2
                            ? Styles.mainColor
                            : Styles.mainColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(24.w),
                      ),
                      child: Icon(
                        Icons.grid_view_rounded,
                        color: const Color(0xff1A1A1A),
                        size: 30.w,
                      ),
                    ),
                  ),
                  ExpandTapWidget(
                    tapPadding: EdgeInsets.all(20.w),
                    onTap: () => tabIndex.value = 3,
                    child: Icon(
                      Icons.manage_accounts,
                      color: tabIndex.value == 3
                          ? Styles.mainColor
                          : Styles.infoGrayColor,
                      size: 30.w,
                    ),
                  ),
                  ExpandTapWidget(
                    tapPadding: EdgeInsets.all(20.w),
                    onTap: () => tabIndex.value = 4,
                    child: Icon(
                      Icons.person_2_outlined,
                      color: tabIndex.value == 4
                          ? Styles.mainColor
                          : Styles.infoGrayColor,
                      size: 30.w,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
