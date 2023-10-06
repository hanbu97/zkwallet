import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/ffi.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/config/styles.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:openim_common/openim_common.dart';

import 'logic.dart';
import 'widgets/create.dart';

class NewWalletPage extends StatefulWidget {
  const NewWalletPage({super.key});

  @override
  State<NewWalletPage> createState() => _NewWalletPageState();
}

class _NewWalletPageState extends State<NewWalletPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  bool showPasswd = true;
  bool showConfirmPasswd = true;

  RxBool agreementChecked = false.obs;
  RxBool encryptMnemonicChecked = false.obs;

  late int length;
  late String lang;
  final nameController = TextEditingController();
  final passwd = TextEditingController();
  final passwdConfirm = TextEditingController();

  // create step
  List<bool> completedCreateSteps = [false, false, false];
  final createStep = 0.obs;

  PolkadotAddress? polkaWallet;

  // verify backup
  final verifyInputs = <String>[].obs;
  final RxList<String> verifyTabs = <String>[].obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    setState(() {
      length = 12;
      lang = 'English';
    });
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
              const CreateWallet(),
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
