import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rust_bridge_template/ffi.dart';
import 'package:flutter_rust_bridge_template/utils/log/logger.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/config/styles.dart';
import '../../../utils/route/app_navigator.dart';
import '../../../widgets/agreements/create_wallet.dart';
import '../../../widgets/selectDown.dart';
import '/utils/extension/custom_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:openim_common/openim_common.dart';

import 'logic.dart';

class NewWalletPage extends StatefulWidget {
  const NewWalletPage({super.key});

  @override
  State<NewWalletPage> createState() => _NewWalletPageState();
}

class _NewWalletPageState extends State<NewWalletPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  final PageController _createPageController = PageController();

  bool showPasswd = true;
  bool showConfirmPasswd = true;

  RxBool agreementChecked = false.obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  var words = [
    'acct',
    'fdghj',
    'yrea',
    'nicke',
    'ticket',
    'happy',
    'rooms',
    'content',
    'swaps',
    'month',
    'active',
    'fleet',
  ];

  _renderWord() {
    var array = <Widget>[];
    for (var i = 0; i < words.length; i++) {
      array.add(
        Container(
          width: 85.w,
          height: 45.w,
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            right: (i + 1) % 3 == 0 ? 0 : 18.9.w,
            bottom: 12.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
          ),
          child: Text(words[i],
              style: GoogleFonts.rubik(
                color: Styles.titleColor,
                fontSize: 15.sp,
              )),
        ),
      );
    }
    return array;
  }

  _renderWord4() {
    var array = <Widget>[];
    for (var i = 0; i < words.length; i++) {
      array.add(
        Container(
          width: 60.w,
          height: 32.w,
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            right: (i + 1) % 4 == 0 ? 0 : 18.9.w,
            bottom: 4.w,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFDFDFDF), width: 1.0),
            borderRadius: BorderRadius.circular(4.r),
            color: Colors.white,
          ),
          child: Text(words[i],
              style: GoogleFonts.rubik(
                color: Styles.titleColor,
                fontSize: 15.sp,
              )),
        ),
      );
    }
    return array;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: mq.padding.top)),
          TabBar(
            controller: _tabController,
            indicator: UnderlineTabIndicator(
                insets: EdgeInsets.symmetric(horizontal: 35.w),
                borderSide: BorderSide(color: Styles.mainColor, width: 2.5.w)),
            tabs: <Widget>[
              Tab(
                // text: 'Create',
                child: Text(
                  'Create',
                  style: GoogleFonts.rubik(
                      fontSize: 15.sp,
                      color: Styles.mainColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Tab(
                child: Text(
                  'Import',
                  style: GoogleFonts.rubik(
                      fontSize: 15.sp,
                      color: Styles.mainColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              PageView(
                scrollDirection: Axis.vertical,
                controller: _createPageController,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 32.w,
                      ),
                      Text('Create Wallet',
                          style: GoogleFonts.titilliumWeb(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                              color: Styles.mainColor)),
                      SizedBox(
                        height: 12.w,
                      ),
                      Text('Establish your new wallet.',
                          style: GoogleFonts.rubik(
                              fontSize: 14.sp, color: Styles.infoGrayColor)),
                      SizedBox(height: 20.w),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mnemonics Length',
                              style: GoogleFonts.rubik(
                                color: Styles.titleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 12.w),
                            Container(
                              height: 54.w,
                              // padding: EdgeInsets.symmetric(horizontal: 16.w),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Styles.backgroundColor,
                              ),
                              child: SelectDown(
                                dataSource: ['12', '16', '28'],
                                onChange: (val) => {print(val)},
                                defaultValue: '12',
                              ),
                            ),
                            SizedBox(height: 20.w),
                            Text(
                              'Mnemonics Language',
                              style: GoogleFonts.rubik(
                                  color: Styles.titleColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 12.w),
                            Container(
                              height: 54.w,
                              // padding: EdgeInsets.symmetric(horizontal: 16.w),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                // color: Styles.mainWhiteBg,
                              ),
                              child: SelectDown(
                                dataSource: ['English', '中文'],
                                onChange: (val) => {print(val)},
                                defaultValue: 'English',
                              ),
                            ),
                            SizedBox(height: 20.w),
                            Text(
                              'Wallet Password',
                              style: GoogleFonts.rubik(
                                  color: Styles.titleColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 12.w),
                            Container(
                              height: 54.w,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Styles.backgroundColor,
                              ),
                              child: TextField(
                                style: TextStyle(
                                  color: Styles.titleColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                obscureText: showPasswd,
                                decoration: InputDecoration(
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintText: 'Letters, numbers, min 8 chars',
                                  hintStyle: TextStyle(
                                    color: Styles.infoGrayColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  contentPadding: EdgeInsets.only(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  suffixIcon: IconButton(
                                    splashColor: Colors.transparent,
                                    icon: Icon(
                                      // Choose appropriately between 'visibility_off' and 'visibility'
                                      showPasswd
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Styles.infoGrayColor,
                                    ),
                                    onPressed: () {
                                      // Toggle password visibility
                                      setState(() {
                                        showPasswd = !showPasswd;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.w),
                            Container(
                              // height: 54.w,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Styles.backgroundColor,
                              ),
                              child: TextField(
                                style: TextStyle(
                                  color: Styles.titleColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                obscureText: showConfirmPasswd,
                                decoration: InputDecoration(
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintText: 'Password confirm',
                                  hintStyle: TextStyle(
                                    color: Styles.infoGrayColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  // contentPadding: EdgeInsets.only(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  suffixIcon: IconButton(
                                    splashColor: Colors.transparent,
                                    icon: Icon(
                                      // Choose appropriately between 'visibility_off' and 'visibility'
                                      showPasswd
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Styles.infoGrayColor,
                                    ),
                                    onPressed: () {
                                      // Toggle password visibility
                                      setState(() {
                                        showConfirmPasswd = !showConfirmPasswd;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.w),
                            CreateWalletAgreementWidget(
                              initAgree: agreementChecked,
                            ),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.w),
                          child: SizedBox(
                            // height: 200.h,
                            width: 1000.w,
                            height: 48.w,
                            child: Obx(() => ElevatedButton(
                                  onPressed: () async {
                                    final data = await api.generateWallet(
                                        ss58: 137,
                                        password: null,
                                        length: 12,
                                        lang: 'English');

                                    LogUtil.debug(data.address);
                                    LogUtil.debug(data.miniSecretKey);
                                    LogUtil.debug(data.publicKey);
                                    LogUtil.debug(data.mnemonicPhrase);

                                    // if (agreementChecked.value) {
                                    //   // showNoticePopup(context);
                                    //   _createPageController.nextPage(
                                    //     duration:
                                    //         const Duration(milliseconds: 800),
                                    //     curve: Curves.easeOutCubic,
                                    //   );
                                    // } else {
                                    //   EasyLoading.showError(
                                    //       "Please tick the agreement before continue to complete the next"
                                    //           .tr);
                                    // }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: agreementChecked.value
                                        ? Styles.mainColor
                                        : Styles.mainColor.withOpacity(0.5),
                                    textStyle:
                                        GoogleFonts.rubik(fontSize: 18.sp),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.w),
                                    ),
                                  ),
                                  child: const Text(
                                    'NEXT',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.w,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 32.w,
                            ),
                            Text('Note it Down',
                                style: GoogleFonts.titilliumWeb(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Styles.mainColor)),
                            SizedBox(
                              height: 12.w,
                            ),
                            Text(
                                "Dont't take screenshots to save the seed phrase. You can write down the words in order and keep them stored safely.",
                                style: GoogleFonts.rubik(
                                    fontSize: 14.sp,
                                    color: Styles.infoGrayColor)),
                            SizedBox(height: 20.w),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 20.w, right: 20.w, top: 12.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: const Color(0xFFEFF3F6),
                              ),
                              child: Wrap(
                                direction: Axis.horizontal,
                                children: _renderWord(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Copy Mnemonics to clipboard',
                                style: GoogleFonts.rubik(
                                    fontSize: 12.sp, color: Styles.mainColor),
                              )),
                        ],
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.w),
                          child: SizedBox(
                            // height: 200.h,
                            width: 1000.w,
                            height: 48.w,
                            child: Obx(() => ElevatedButton(
                                  onPressed: () {
                                    if (agreementChecked.value) {
                                      // showNoticePopup(context);
                                      _createPageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 800),
                                        curve: Curves.easeOutCubic,
                                      );
                                    } else {
                                      EasyLoading.showError(
                                          "Please tick the agreement before continue to complete the next"
                                              .tr);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: agreementChecked.value
                                        ? Styles.mainColor
                                        : Styles.mainColor.withOpacity(0.5),
                                    textStyle:
                                        GoogleFonts.rubik(fontSize: 18.sp),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.w),
                                    ),
                                  ),
                                  child: const Text('Verify Backup'),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.w,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 32.w,
                            ),
                            Text('Verify Backup',
                                style: GoogleFonts.titilliumWeb(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 12.w,
                            ),
                            Text(
                                "Please select and fill in the mnemonic words in the order you've written down.",
                                style: GoogleFonts.rubik(
                                    fontSize: 14.sp,
                                    color: const Color.fromARGB(
                                        255, 133, 140, 173))),
                            SizedBox(height: 20.w),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 20.w, right: 20.w, top: 12.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: const Color(0xFFEFF3F6),
                              ),
                              child: Wrap(
                                direction: Axis.horizontal,
                                children: _renderWord(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.w),
                      Center(
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: _renderWord4(),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.w),
                          child: SizedBox(
                            // height: 200.h,
                            width: 1000.w,
                            height: 48.w,
                            child: Obx(() => ElevatedButton(
                                  onPressed: () {
                                    AppNavigator.homepage();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: agreementChecked.value
                                        ? Styles.mainColor
                                        : Styles.mainColor.withOpacity(0.5),
                                    textStyle:
                                        GoogleFonts.rubik(fontSize: 18.sp),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.w),
                                    ),
                                  ),
                                  child: const Text('Confirm'),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.w,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35.w,
                  ),
                  Text('Import Wallet',
                      style: GoogleFonts.titilliumWeb(
                          fontSize: 32.sp, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 12.w,
                  ),
                  Text('Create Wallet',
                      style: GoogleFonts.rubik(
                          fontSize: 14.sp,
                          color: Color.fromARGB(255, 133, 140, 173))),
                ],
              ),
            ],
          ))
        ],
      ),
      // Column(
      //   children: [],
      // ),
    );
  }
}
