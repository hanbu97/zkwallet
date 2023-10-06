import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waterspay/screens/wallet/create_import/widgets/import.dart';
import '/ffi.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/config/styles.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'logic.dart';
import 'widgets/create.dart';

class NewWalletPage extends StatefulWidget {
  const NewWalletPage({super.key});

  @override
  State<NewWalletPage> createState() => _NewWalletPageState();
}

class _NewWalletPageState extends State<NewWalletPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

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
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            children: const <Widget>[CreateAccount(), ImportAccount()],
          ))
        ],
      ),
    );
  }
}
