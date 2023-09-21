import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rust_bridge_template/utils/config/styles.dart';
import 'package:flutter_rust_bridge_template/utils/encryption/general.dart';
import 'package:flutter_rust_bridge_template/utils/log/logger.dart';
import 'package:flutter_rust_bridge_template/utils/rand/rand_string.dart';
import 'package:flutter_rust_bridge_template/utils/state/data_sp.dart';
import 'package:flutter_rust_bridge_template/utils/storage/general.dart';
import 'package:flutter_rust_bridge_template/widgets/confirm/confirm_text_pin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vara_sdk/api/apiKeyring.dart';
import 'package:vara_sdk/api/types/balanceData.dart';
import 'package:vara_sdk/api/types/txInfoData.dart';
import 'package:vara_sdk/plugin/index.dart';
import 'package:vara_sdk/storage/keyring.dart';

import '../../../utils/string/string_utils.dart';
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
  double _estimateGas = 0.0;

  // controllers
  final _receiverController = TextEditingController();
  final _amountController = TextEditingController();

  Future<void> _getBalance() async {
    setState(() {
      // _balance = newBalance.first;
    });
  }

  void estimateGas() async {
    final sender = TxSenderData(widget.wallet, null);
    final txInfo = TxInfoData('balances', 'transfer', sender);

    final res = await DataSp.varaSdk.api.tx
        .estimateFees(txInfo, [widget.wallet, '10000000000']);

    setState(() {
      _estimateGas = res.partialFee.toString().toBalance();
    });
  }

  Future<Map<dynamic, dynamic>?> sendTx(String value) async {
    final data = await dbGetGroupWallet(
        HiveDBName.walletGroup, DataSp.selectedWalletRead.address!);
    final mnemonics =
        Encryption.decrypt(data.mnemonics, value, EncryptionMethod.fernet);

    final tmpPassword = generateRandomString(16);
    final json = await DataSp.varaSdk.api.keyring.importAccount(
      DataSp.keyRing,
      keyType: KeyType.mnemonic,
      key: mnemonics,
      name: tmpPassword.substring(0, 8),
      password: tmpPassword,
    );
    final acc = await DataSp.varaSdk.api.keyring.addAccount(
      DataSp.keyRing,
      keyType: KeyType.mnemonic,
      acc: json!,
      password: tmpPassword,
    );

    LogUtil.debug(acc.toJson());

    final sender = TxSenderData(
      DataSp.keyRing.keyPairs[0].address,
      DataSp.keyRing.keyPairs[0].pubKey,
    );
    final txInfo = TxInfoData('balances', 'transfer', sender);

    final hash = await DataSp.varaSdk.api.tx.signAndSend(
      txInfo,
      [
        // params.to
        // _testAddressGav,
        // 'GvrJix8vF8iKgsTAfuazEDrBibiM6jgG66C6sT2W56cEZr3',
        _receiverController.text,
        // params.amount
        // '10000000000'
        _amountController.text.toBigIntStr()
      ],
      tmpPassword,
    );

    return hash;
  }

  @override
  void initState() {
    super.initState();
    _getBalance();
    estimateGas();
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
                          color: Styles.infoGrayColor,
                          fontSize: 16.w,
                          fontWeight: FontWeight.w700),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                SizedBox(
                  height: 15.w,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Styles.mainColor),
                      borderRadius: BorderRadius.circular(12.w)),
                  padding: EdgeInsets.only(left: 15.w),
                  child: TextField(
                    controller: _receiverController,
                    style: TextStyle(
                      color: Styles.titleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: 'Send to Address',
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
            height: 40.w,
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
                          color: Styles.infoGrayColor,
                          fontSize: 16.w,
                          fontWeight: FontWeight.w700),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      StringUtils.toDotDouble(
                              widget.balance?.freeBalance ?? '0x0')
                          .toString(),
                      style: TextStyle(
                          color: Styles.mainColor, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 6.w,
                    )
                  ],
                ),
                SizedBox(
                  height: 15.w,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Styles.mainColor),
                      borderRadius: BorderRadius.circular(12.w)),
                  padding: EdgeInsets.only(left: 15.w),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: _amountController,
                        style: TextStyle(
                          color: Styles.titleColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          hintText: 'Please enter the transfer amount',
                          hintStyle: TextStyle(
                            color: Styles.infoGrayColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: const EdgeInsets.only(),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      )),
                      TextButton(
                          onPressed: () {
                            _amountController.text = (StringUtils.toDotDouble(
                                        widget.balance?.freeBalance ?? '0x0') -
                                    _estimateGas * 2)
                                .floor()
                                .toString();
                          },
                          child: Text(
                            'MAX',
                            style: TextStyle(color: Styles.mainColor),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Styles.backgroundColor,
              ),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "Estimated Gas",
                      style: TextStyle(
                          color: Styles.infoGrayColor,
                          fontSize: 14.w,
                          fontWeight: FontWeight.w700),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      _estimateGas.toString(),
                      style: TextStyle(
                          color: Styles.mainColor,
                          fontSize: 12.w,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ])),
          const Expanded(child: SizedBox()),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: SizedBox(
                width: 1000.w,
                height: 48.w,
                child: ElevatedButton(
                  onPressed: () async {
                    confirmTextPin().then((value) async {
                      try {
                        EasyLoading.show(status: 'Sending...');

                        final hash = await sendTx(value ?? '');
                        if (hash != null) {
                          LogUtil.debug('sendTx  $value');
                          EasyLoading.dismiss();
                          Get.snackbar('Send',
                              'Send ${_amountController.text} VARA to ${_receiverController.text} success!}',
                              colorText: Styles.mainWhite);

                          // Get.back();
                          Navigator.pop(context);
                        } else {
                          EasyLoading.dismiss();
                          EasyLoading.showError('Hash is null');
                        }
                      } catch (err) {
                        EasyLoading.dismiss();
                        EasyLoading.showError(err.toString());
                        LogUtil.debug('sendTx  ${err.toString()}');
                      }
                    });
                  },
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
          SizedBox(
            height: 32.w,
          ),
        ],
      ),
    );
  }
}
