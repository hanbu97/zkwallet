import 'dart:math';

import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:waterspay/screens/home/wallet/pages/select_network/screen.dart';
import 'package:waterspay/screens/home/wallet/test_sol.dart';
import '/main.dart';
import '/screens/home/receive/receive.dart';
import '/screens/home/send/send.dart';
import '/utils/config/images.dart';
import '/utils/extension/custom_ext.dart';
import '/utils/log/logger.dart';
import '/utils/state/data_sp.dart';
import '/utils/state/sp_util.dart';
import '/utils/storage/general.dart';
import '/utils/string/string_utils.dart';
import '/widgets/assets/coin_icon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vara_sdk/api/types/balanceData.dart';

import '../../../utils/config/styles.dart';
import 'logic.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  BalanceData? _balance;
  String? _msgChannel;

  late WalletLogic walletLogic;

  Future<void> _subscribeBalance() async {
    final channel = await DataSp.varaSdk.api.account
        .subscribeBalance(walletLogic.selectedWallet.address, (res) {
      setState(() {
        _balance = res;
      });
    });
    setState(() {
      _msgChannel = channel;
    });
  }

  @override
  void initState() {
    super.initState();
    walletLogic = Get.find<WalletLogic>();
    _subscribeBalance();
  }

  @override
  void dispose() {
    if (_msgChannel != null) {
      DataSp.varaSdk.api.unsubscribeMessage(_msgChannel!);
    }
    super.dispose();
  }

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
            ExpandTapWidget(
              onTap: () async {
                final wallet = walletLogic.selectedWallet.address;
                final res =
                    await DataSp.varaSdk.api.account.queryBalance(wallet);

                LogUtil.debug(res?.availableBalance);
              },
              tapPadding: EdgeInsets.all(10.w),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
                decoration: BoxDecoration(
                    color: const Color(0xff263530),
                    borderRadius: BorderRadius.circular(20.w)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      // 'Gshock-okk',
                      StringUtils.truncateString(
                          walletLogic.selectedWallet.address!,
                          maxLength: 20),
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
            ),
          ],
        ),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/images/icons/eth.png',
              //   width: 16.w,
              //   height: 16.w,
              // ),
              // SizedBox(
              //   width: 4.w,
              // ),

              GestureDetector(
                onTap: () {
                  Get.to(const MyHomePage(
                    title: 'zk',
                  ));
                },
                child: Text(DataSp.selectedWalletGroupName,
                    style: GoogleFonts.titilliumWeb(
                        fontSize: 14.sp,
                        color: Styles.titleColor,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(
            width: 10.w,
          ),
          GestureDetector(
            onTap: () {
              // await dbClear(HiveDBName.walletGroup);
              // await SpUtil().clear();
              // Get.to(MyHomePage(
              //   title: 'zk',
              // ));
              // showModalBottomSheet(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return Container(
              //       child: Wrap(
              //         children: <Widget>[
              //           ListTile(
              //             leading: Icon(Icons.music_note),
              //             title: Text('Music'),
              //             onTap: () => {},
              //           ),
              //           ListTile(
              //             leading: Icon(Icons.videocam),
              //             title: Text('Video'),
              //             onTap: () => {},
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // );
              Get.to(
                  Dismissible(
                    direction: DismissDirection.down,
                    key: const Key('dismissible_network_select'),
                    confirmDismiss: (direction) async {
                      Get.back();
                      return true;
                    },
                    child: SelectNetworkPage(),
                  ),
                  opaque: false,
                  transition: Transition.downToUp,
                  fullscreenDialog: true);
            },
            child: Container(
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
          ),
          SizedBox(
            width: 12.w,
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Styles.contentPadding(
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
                        const Color.fromRGBO(2, 86, 255, 0.6),
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
                          '\$ ${StringUtils.toDotDoubleStr(_balance?.freeBalance ?? '0x0')}',
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
                            ExpandTapWidget(
                              onTap: () {
                                Get.to(ReceivePage(
                                    wallet:
                                        walletLogic.selectedWallet.address!));
                              },
                              tapPadding: EdgeInsets.all(10.w),
                              child: Container(
                                height: 48.w,
                                width: 48.w,
                                padding: EdgeInsets.all(11.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.w),
                                  color: Styles.mainColorDark,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 2.w,
                                    ),
                                    Icon(
                                      Icons.download,
                                      color: Colors.white,
                                      size: 22.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ExpandTapWidget(
                              onTap: () {
                                Get.to(SendPage(
                                    balance: _balance,
                                    wallet:
                                        walletLogic.selectedWallet.address!));
                              },
                              tapPadding: EdgeInsets.all(10.w),
                              child: Container(
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
                            GestureDetector(
                              onTap: () {
                                Get.to(const TestSolanaPage());
                              },
                              child: Container(
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
                              ),
                            )
                          ],
                        ),
                      )))
            ],
          ),
          SizedBox(
            height: 30.w,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text("Tokens",
                      style: TextStyle(
                        color: Styles.mainWhite,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      )),
                  const Expanded(child: SizedBox()),
                  Icon(Icons.search, color: Styles.infoGrayColor, size: 24.w)
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              MenuItem(
                name: 'ZKP',
                logo: 'assets/images/zklogo.png',
                routeName: '/createWallet',
                desp: '\$1.92',
              ),
              SizedBox(
                height: 10.w,
              ),
              MenuItem(
                name: 'VARA',
                routeName: '/createWallet',
                desp: '\$2.52',
              ),
              SizedBox(
                height: 10.w,
              ),
              MenuItem(
                name: 'DOT',
                routeName: '/createWallet',
                desp: '\$7.22',
              ),
              SizedBox(
                height: 10.w,
              ),
              MenuItem(
                name: 'BTC',
                routeName: '/createWallet',
                desp: '\$26,225.40',
              ),
            ],
          ),
          SizedBox(
            height: 30.w,
          ),
        ],
      ))),
    );
  }
}

// 操作按钮组件
class MenuItem extends StatelessWidget {
  const MenuItem(
      {Key? key,
      required this.name,
      this.logo,
      this.routeName,
      this.desp,
      this.amount})
      : super(key: key);
  final String name; // 名称
  final String? logo; // logo
  final double? amount;
  final routeName; // 路由跳转地址
  final desp;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Get.toNamed(routeName),
        child: Container(
          height: 58.w,
          // margin: EdgeInsets.symmetric(vertical: 36.w),
          decoration: const BoxDecoration(color: Color(0xff1A1A1A)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 12.w,
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
                      child: logo == null
                          ? Container(
                              color: Colors.white,
                              child: Center(
                                child: coinIcon(name),
                              ),
                            )
                          : (logo!).toImage)),
              SizedBox(width: 11.w),
              Expanded(
                  child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: Styles.contentWhite),
                      SizedBox(
                        height: 2.w,
                      ),
                      Text(desp,
                          style: GoogleFonts.rubik(
                            color: Styles.mainColorDark,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('3.920',
                          style: GoogleFonts.rubik(
                            color: Styles.mainWhite,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          )),
                      SizedBox(
                        height: 2.w,
                      ),
                      Text('\$25.112',
                          style: GoogleFonts.rubik(
                            color: Styles.mainColorDark,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 22.w,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                ],
              )),
            ],
          ),
        ));
  }
}
