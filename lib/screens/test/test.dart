import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waterspay/models/wallet/wallet_types.dart';
import 'package:waterspay/utils/config/styles.dart';
import 'package:waterspay/utils/log/logger.dart';
import 'package:waterspay/utils/state/data_sp.dart';
// import 'package:waterspay/utils/state/wallet_type.dart/wallet_type.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Styles.mainColor,
          height: 200.w,
          width: 200.w,
          child: TextButton(
              child: const Text('data'),
              onPressed: () async {
                final t = DataSp.walletTypeSp.getWalletTypes();
                LogUtil.debug(t);
              }),
        ),
      ),
    );
  }
}
