import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rust_bridge_template/utils/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vara_sdk/api/types/balanceData.dart';

import 'widgets/gas_select.dart';

class SendPage extends StatefulWidget {
  SendPage({
    super.key,
    required this.balance,
    this.wallet,
  });

  String? wallet;
  BalanceData? balance;

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  var _selectedGas = 1;
  var _balance = 0.0;

  // controllers
  final _addressController = TextEditingController();
  final _amountController = TextEditingController();

  final _notesController = TextEditingController();

  Future<void> _getBalance() async {
    setState(() {
      // _balance = newBalance.first;
    });
  }

  void _handleButtonPressed(int index) {
    setState(() {
      _selectedGas = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      appBar: AppBar(
        backgroundColor: Styles.backgroundColor,
        title: Text(
          "Send",
          style: TextStyle(color: Styles.mainColor),
        ),
        leading: BackButton(color: Styles.mainColor),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.qr_code_scanner_outlined,
                color: Styles.mainColor,
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15.w,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Styles.backgroundColor,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Receiver",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.w,
                          fontWeight: FontWeight.w700),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                SizedBox(
                  height: 10.w,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Styles.mainColor),
                      borderRadius: BorderRadius.circular(12.w)),
                  padding: EdgeInsets.only(left: 15.w),
                  child: TextField(
                    // controller: passwdConfirm,
                    style: TextStyle(
                      color: Styles.titleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    // obscureText: showConfirmPasswd,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: 'Password confirm',
                      hintStyle: TextStyle(
                        color: Styles.infoGrayColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.only(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.w,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Styles.backgroundColor,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.w,
                          fontWeight: FontWeight.w700),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                SizedBox(
                  height: 10.w,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Styles.mainColor),
                      borderRadius: BorderRadius.circular(12.w)),
                  padding: EdgeInsets.only(left: 15.w),
                  child: TextField(
                    // controller: passwdConfirm,
                    style: TextStyle(
                      color: Styles.titleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    // obscureText: showConfirmPasswd,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: 'Password confirm',
                      hintStyle: TextStyle(
                        color: Styles.infoGrayColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.only(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
              color: Colors.white,
              // padding: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Receiver",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.book)
                        ],
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: TextField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Please enter receiving address'.tr,
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: SizedBox(),
                          )
                        ],
                      )
                    ],
                  ))),
          SizedBox(
            height: 10,
          ),
          Container(
              color: Colors.white,
              // padding: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Amount",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            "FIL >",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _amountController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Please enter amount'.tr,
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(4),
                                  onTap: () {
                                    // TODO: 按钮点击事件
                                    setState(() {
                                      _amountController.text =
                                          _balance.toString();
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'ALL',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Text(
                            "Balance",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            _balance.toString(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ))),
          SizedBox(
            height: 10,
          ),
          const SizedBox(),
          Container(
              color: Colors.white,
              // padding: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                  padding: EdgeInsets.only(top: 15, right: 15, left: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Estimated Fee",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: GasButtonRow(
                            labels: ["Slow", "REC", "Fast", "Customize"],
                            onButtonPressed: _handleButtonPressed,
                            // onButtonPressed: () => {},
                          )),
                    ],
                  ))),
          SizedBox(
            height: 10,
          ),
          const Expanded(child: SizedBox()),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: SizedBox(
                width: 1000.w,
                height: 48.w,
                child: ElevatedButton(
                  onPressed: () {},
                  //   completedCreateSteps[1] = true;
                  //   _createPageController.nextPage(
                  //     duration: const Duration(milliseconds: 800),
                  //     curve: Curves.easeOutCubic,
                  //   );

                  //   // init verify datas
                  //   verifyInputs.value = [];
                  //   var _t = _words.toList();
                  //   _t.shuffle();
                  //   verifyTabs.value = _t;
                  // },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.mainColor,
                    textStyle: GoogleFonts.rubik(fontSize: 18.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
                // child: Obx(() => ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
