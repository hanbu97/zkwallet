import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../bridge_definitions.dart';
import '../../../../ffi.dart';
import '../../../../models/wallet/wallet_types.dart';
import '../../../../models/wallet/wallets.dart';
import '../../../../models/wallet/wallets_group.dart';
import '../../../../utils/config/styles.dart';
import '../../../../utils/encryption/general.dart';
import '../../../../utils/log/logger.dart';
import '../../../../utils/route/app_navigator.dart';
import '../../../../utils/state/data_sp.dart';
import '../../../../widgets/agreements/create_wallet.dart';
import '../../../../widgets/agreements/encrypt_mnemonics.dart';
import '../../../../widgets/selectDown.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final PageController _createPageController = PageController();

  List<bool> completedCreateSteps = [false, false, false];
  final verifyInputs = <String>[].obs;
  final RxList<String> verifyTabs = <String>[].obs;
  RxBool encryptMnemonicChecked = false.obs;

  RxBool agreementChecked = false.obs;

  bool showPasswd = true;
  bool showConfirmPasswd = true;
  final passwd = TextEditingController();
  final passwdConfirm = TextEditingController();

  // PolkadotAddress? newAccount;
  WalletAddress? newAccount;
  final _words = <String>[].obs;
  final nameController = TextEditingController();

  // mnemonic params
  int length = 12;
  String lang = 'English';

  _renderWord() {
    var array = <Widget>[];
    final words = newAccount?.mnemonicPhrase.split(' ') ?? [];

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
            color: const Color(0xFF222225),
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

  _renderWordVerify() {
    var array = <Widget>[];

    for (var i = 0; i < verifyInputs.length; i++) {
      array.add(
        GestureDetector(
          onTap: () {
            if (verifyTabs.length < length) {
              verifyTabs.add(verifyInputs[i]);
              verifyInputs.removeAt(i);
            }
          },
          child: Container(
            width: 85.w,
            height: 45.w,
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              right: (i + 1) % 3 == 0 ? 0 : 18.9.w,
              bottom: 12.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: const Color(0xFF222225),
            ),
            child: Text(verifyInputs[i],
                style: GoogleFonts.rubik(
                  color: Styles.titleColor,
                  fontSize: 15.sp,
                )),
          ),
        ),
      );
    }
    return array;
  }

  _renderWord4() {
    var array = <Widget>[];
    for (var i = 0; i < verifyTabs.length; i++) {
      array.add(
        GestureDetector(
          onTap: () {
            if (verifyInputs.length < length) {
              verifyInputs.add(verifyTabs[i]);
              verifyTabs.removeAt(i);
            }
          },
          child: Container(
            width: 60.w,
            height: 32.w,
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              right: (i + 1) % 4 == 0 ? 0 : 18.9.w,
              bottom: 4.w,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF303033), width: 1.0),
              borderRadius: BorderRadius.circular(4.r),
              color: const Color(0xFF303033),
            ),
            child: Text(verifyTabs[i],
                style: GoogleFonts.rubik(
                  color: Styles.titleColor,
                  fontSize: 12.sp,
                )),
          ),
        ),
      );
    }
    return array;
  }

  @override
  Widget build(BuildContext context) {
    Widget createStep1() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.w,
          ),
          Text('Create Account',
              style: GoogleFonts.titilliumWeb(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                  color: Styles.mainColor)),
          Text('Establish your new wallet group.',
              style: GoogleFonts.rubik(
                  fontSize: 14.sp, color: Styles.infoGrayColor)),
          SizedBox(
            height: 28.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Name',
                  style: GoogleFonts.rubik(
                      color: Styles.titleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12.w),
                Container(
                  height: 30.w,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Styles.backgroundColor,
                  ),
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(
                      color: Styles.titleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: 'Please input name of account',
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
                  ),
                ),
                SizedBox(height: 20.w),
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
                  height: 30.w,
                  // padding: EdgeInsets.symmetric(horizontal: 16.w),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Styles.backgroundColor,
                  ),
                  child: SelectDown(
                    dataSource: const ['12', '15', '18', '21', '24'],
                    onChange: (val) => {
                      setState(() {
                        length = int.parse(val);
                      })
                    },
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
                  height: 30.w,
                  // padding: EdgeInsets.symmetric(horizontal: 16.w),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    // color: Styles.mainWhiteBg,
                  ),
                  child: SelectDown(
                    dataSource: const [
                      'English',
                      'ChineseSimplified',
                      'ChineseTraditional',
                      'French',
                      'Italian',
                      'Japanese',
                      'Korean',
                      'Spanish'
                    ],
                    onChange: (val) => {
                      setState(() {
                        lang = val;
                      })
                    },
                    defaultValue: 'English',
                  ),
                ),
                SizedBox(height: 20.w),
                Text(
                  'Account Password',
                  style: GoogleFonts.rubik(
                      color: Styles.titleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12.w),
                Container(
                  height: 30.w,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Styles.backgroundColor,
                  ),
                  child: TextField(
                    controller: passwd,
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
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(
                          // Choose appropriately between 'visibility_off' and 'visibility'
                          showPasswd ? Icons.visibility_off : Icons.visibility,
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
                // SizedBox(height: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Styles.backgroundColor,
                  ),
                  child: TextField(
                    controller: passwdConfirm,
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
                      contentPadding: EdgeInsets.only(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(
                          // Choose appropriately between 'visibility_off' and 'visibility'
                          showPasswd ? Icons.visibility_off : Icons.visibility,
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
                // SizedBox(height: 20.w),
                EncryptMnemonicsWidget(
                  initAgree: encryptMnemonicChecked,
                ),
              ],
            )),
          ),
          const Expanded(child: SizedBox()),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: SizedBox(
                // height: 200.h,
                width: 1000.w,
                // height: 48.w,
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CreateWalletAgreementWidget(
                          initAgree: agreementChecked,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 48.w,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (agreementChecked.value) {
                                if (passwd.text != passwdConfirm.text) {
                                  EasyLoading.showError(
                                      "Password not match".tr);
                                  return;
                                }
                                if (passwd.text.length < 8) {
                                  EasyLoading.showError(
                                      "Password length must be greater than 8"
                                          .tr);
                                  return;
                                }

                                // final data = await api.generateWallet(
                                //     ss58: 137,
                                //     password: encryptMnemonicChecked.value
                                //         ? passwd.text
                                //         : null,
                                //     length: length,
                                //     lang: lang);

                                // _words.value = data.mnemonicPhrase.split(' ');
                                // setState(() {
                                //   newAccount = data;
                                // });

                                final data = await api.generateWalletMulti(
                                  chain: 'sol',
                                  length: length,
                                  lang: lang,
                                  params: jsonEncode({"ss58": 137}),
                                  password: encryptMnemonicChecked.value
                                      ? passwd.text
                                      : null,
                                );

                                _words.value = data.mnemonicPhrase.split(' ');
                                setState(() {
                                  newAccount = data;
                                });

                                LogUtil.debug(newAccount?.address);
                                // LogUtil.debug(newAccount?.miniSecretKey);
                                LogUtil.debug(newAccount?.secretKey);
                                LogUtil.debug(newAccount?.address);
                                // LogUtil.debug(newAccount?.mnemonicPhrase);

                                completedCreateSteps[0] = true;
                                _createPageController.nextPage(
                                  duration: const Duration(milliseconds: 800),
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
                              textStyle: GoogleFonts.rubik(fontSize: 18.sp),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                            ),
                            child: const Text(
                              'NEXT',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 32.w,
          ),
        ],
      );
    }

    Widget createStep2() {
      return Column(
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
                        fontSize: 14.sp, color: Styles.infoGrayColor)),
                SizedBox(height: 20.w),
                Container(
                  height: length == 12 ? 258.w : 285.w,
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, top: 20.w, bottom: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: const Color(0xFF303033),
                  ),
                  child: SingleChildScrollView(
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: _renderWord(),
                    ),
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
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: newAccount?.mnemonicPhrase ?? ''));
                    Get.snackbar('Create Wallet', 'Copied to clipboard',
                        colorText: Colors.white);
                  },
                  child: Text(
                    'Copy Mnemonics to clipboard',
                    style: GoogleFonts.rubik(
                        fontSize: 12.sp, color: Styles.mainColor),
                  )),
            ],
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: SizedBox(
                // height: 200.h,
                width: 1000.w,
                height: 48.w,
                child: Obx(() => ElevatedButton(
                      onPressed: () {
                        completedCreateSteps[1] = true;
                        _createPageController.nextPage(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutCubic,
                        );

                        // init verify datas
                        verifyInputs.value = [];
                        var _t = _words.toList();
                        _t.shuffle();
                        verifyTabs.value = _t;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: agreementChecked.value
                            ? Styles.mainColor
                            : Styles.mainColor.withOpacity(0.5),
                        textStyle: GoogleFonts.rubik(fontSize: 18.sp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                      ),
                      child: const Text(
                        'Verify Backup',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 32.w,
          ),
        ],
      );
    }

    Widget createStep3() {
      return Column(
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
                        fontWeight: FontWeight.w600,
                        color: Styles.mainColor)),
                SizedBox(
                  height: 12.w,
                ),
                Text(
                    "Please select and fill in the mnemonic words in the order you've written down.",
                    style: GoogleFonts.rubik(
                        fontSize: 14.sp, color: Styles.infoGrayColor)),
                SizedBox(height: 20.w),
                Container(
                  width: double.infinity,
                  height: length == 12 ? 258.w : 285.w,
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: const Color(0xFF303033),
                  ),
                  child: Obx(() => SingleChildScrollView(
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: _renderWordVerify(),
                        ),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.w),
          Center(
            child: SizedBox(
              height: length == 12 ? 108.w : 133.w,
              // padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 12.w),
              child: Obx(() => SingleChildScrollView(
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: _renderWord4(),
                    ),
                  )),
            ),
          ),
          const Expanded(child: SizedBox()),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: SizedBox(
                // height: 200.h,
                width: 1000.w,
                height: 48.w,
                child: Obx(() => ElevatedButton(
                      onPressed: () async {
                        if (verifyInputs.length != length) {
                          EasyLoading.showError(
                              'Please fill in all the mnemonic words'.tr);
                          return;
                        }
                        if (verifyInputs.join(' ') !=
                            newAccount?.mnemonicPhrase) {
                          EasyLoading.showError(
                              'The mnemonic words you filled in are incorrect'
                                  .tr);
                          return;
                        }

                        // safe save wallet
                        String mnemonicStr = "";
                        mnemonicStr = verifyInputs.join(' ');
                        mnemonicStr = Encryption.encrypt(mnemonicStr,
                            passwdConfirm.text, EncryptionMethod.fernet);

                        late WalletGroup walletGroup;
                        final wallet = Wallet(
                            name: "0".toString(),
                            address: newAccount!.address,
                            // secretKey: newAccount!.miniSecretKey,
                            secretKey: newAccount!.secretKey,
                            mnemonics: mnemonicStr,
                            walletMode: 0);

                        final walletGroupIdx =
                            DataSp.increaseWalletGroupMaxID();
                        // final walletType = WalletType(name: "vara-testnet");
                        walletGroup = WalletGroup(
                            idx: walletGroupIdx,
                            // name: newAccount!.address,
                            name: nameController.text,
                            mnemonics: [mnemonicStr],
                            wallets: [wallet],
                            walletTypes: []);

                        DataSp.addWalletGroup(walletGroup);

                        // var walletGroupRead = walletGroup.toWalletGroupRead();
                        // DataSp.addWalletGroupRead(walletGroupRead);
                        // await dbAdd(HiveDBName.walletGroup, walletGroup);

                        AppNavigator.homepage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: agreementChecked.value
                            ? Styles.mainColor
                            : Styles.mainColor.withOpacity(0.5),
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
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 32.w,
          ),
        ],
      );
    }

    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _createPageController,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return createStep1();
          case 1:
            if (completedCreateSteps[0]) {
              return createStep2();
            }
          case 2:
            if (completedCreateSteps[1]) {
              return createStep3();
            }
        }
      },
    );
  }
}
