import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:solana/solana.dart' as Solana;
// import 'package:solana_mobile_client';

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

class ImportAccount extends StatefulWidget {
  const ImportAccount({super.key});

  @override
  State<ImportAccount> createState() => _ImportAccountState();
}

class _ImportAccountState extends State<ImportAccount> {
  final PageController _createPageController = PageController();

  List<bool> completedCreateSteps = [false, false];
  final mnemonicInputs = <String>[].obs;
  final mnemonicStates = <bool>[].obs;
  final inputFocus = <FocusNode>[].obs;

  RxBool encryptMnemonicChecked = false.obs;
  RxBool agreementChecked = false.obs;

  bool showPasswd = true;
  bool showConfirmPasswd = true;
  final passwd = TextEditingController();
  final passwdConfirm = TextEditingController();

  PolkadotAddress? newAccount;
  final _words = <String>[].obs;
  final nameController = TextEditingController();

  // mnemonic params
  int length = 1;
  String lang = 'English';

  final currentWord = "".obs;
  RxList<String> suggestWords = <String>[].obs;

  _renderWordVerify() {
    var array = <Widget>[];

    // for (var i = 0; i < mnemonicInputs.length; i++) {
    for (var i = 0; i < length; i++) {
      array.add(mnemonicStates[i]
          ? Container(
              width: 85.w,
              height: 45.w,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                right: (i + 1) % 3 == 0 ? 0 : 18.9.w,
                bottom: 12.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                // border: Border.all(color: Styles.mainColorDark, width: 1.w),
                color: const Color(0xFF222225),
              ),
              child: Text(mnemonicInputs[i],
                  style: GoogleFonts.rubik(
                    color: Styles.titleColor,
                    fontSize: 15.sp,
                  )),
            )
          : SizedBox(
              width: 85.w,
              height: 45.w,
              child: TextField(
                autofocus: true,
                focusNode: inputFocus[i],
                controller: TextEditingController(text: mnemonicInputs[i]),
                cursorColor: Styles.mainColor,
                style: TextStyle(color: Styles.mainColor),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Styles.mainColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Styles.mainColor),
                  ),
                ),
                onChanged: (value) async {
                  currentWord.value = value.replaceAll(' ', '');

                  if (currentWord.value.isNotEmpty) {
                    suggestWords.value = await api.wordSuggestion(
                        word: currentWord.value, lang: lang);
                  }

                  LogUtil.debug(suggestWords);

                  if (value.length - value.replaceAll(' ', '').length == 2) {
                    mnemonicInputs[i] = value.replaceAll(' ', '');
                    mnemonicStates[i] = true;
                    if (i == length - 1) {
                      length += 1;
                      mnemonicInputs.add(' ');
                      mnemonicStates.add(false);
                      inputFocus.add(FocusNode());
                    }
                  }
                  if (value.isEmpty) {
                    mnemonicInputs[i] = ' ';
                    mnemonicStates[i] = false;

                    if (i != 0) {
                      length -= 1;
                      mnemonicStates[i - 1] = false;
                      mnemonicInputs[i - 1] =
                          [" ", mnemonicInputs[i - 1]].join();
                    }
                  }
                },
              ),
            ));

      if (mnemonicStates[i] == false) {
        inputFocus[i].requestFocus();
      }
    }

    return array;
  }

  @override
  void initState() {
    super.initState();
    mnemonicInputs.add(' ');
    mnemonicStates.add(false);
    inputFocus.add(FocusNode());
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
          Text('Import Account',
              style: GoogleFonts.titilliumWeb(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                  color: Styles.mainColor)),
          Text('Import your wallet group from mnemonics.',
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

                                final data = await api.generateWallet(
                                    ss58: 137,
                                    password: encryptMnemonicChecked.value
                                        ? passwd.text
                                        : null,
                                    length: length,
                                    lang: lang);

                                _words.value = data.mnemonicPhrase.split(' ');

                                setState(() {
                                  newAccount = data;
                                });

                                LogUtil.debug(newAccount?.address);
                                LogUtil.debug(newAccount?.miniSecretKey);
                                LogUtil.debug(newAccount?.publicKey);
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
      return SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
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
                    Text('Import Mnemonics',
                        style: GoogleFonts.titilliumWeb(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600,
                            color: Styles.mainColor)),
                    SizedBox(height: 20.w),
                    Container(
                      width: double.infinity,
                      height: length == 12 ? 258.w : 285.w,
                      padding:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 12.w),
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
                    SizedBox(height: 20.w),
                    Text(
                        '''Use your mnemonic phrase - it's essential for enabling multiple chain derivation. Feel free to import your wallet using a private key, but only after your account is established. 
                    \nNote: password encryption of your mnemonic phrase will alter results.''',
                        style: GoogleFonts.rubik(
                            fontSize: 14.sp, color: Styles.infoGrayColor)),
                  ],
                ),
              ),
              SizedBox(height: 100.w),
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
                            // safe save wallet
                            String mnemonicStr = "";
                            mnemonicStr =
                                mnemonicInputs.sublist(0, length).join(' ');

                            try {
                              newAccount =
                                  await api.generateWalletFromMnemonics(
                                      ss58: 137,
                                      phrase: mnemonicStr,
                                      lang: lang); //

                              mnemonicStr = Encryption.encrypt(mnemonicStr,
                                  passwdConfirm.text, EncryptionMethod.fernet);

                              late WalletGroup walletGroup;
                              final wallet = Wallet(
                                  name: "0".toString(),
                                  address: newAccount!.address,
                                  secretKey: newAccount!.miniSecretKey,
                                  mnemonics: mnemonicStr,
                                  walletMode: 0);

                              final walletGroupIdx =
                                  DataSp.increaseWalletGroupMaxID();
                              // final walletType =
                              //     WalletType(name: "vara-testnet");
                              walletGroup = WalletGroup(
                                  idx: walletGroupIdx,
                                  // name: newAccount!.address,
                                  name: nameController.text,
                                  mnemonics: [mnemonicStr],
                                  wallets: [wallet],
                                  walletTypes: []);

                              DataSp.addWalletGroup(walletGroup);

                              AppNavigator.homepage();
                            } catch (e) {
                              EasyLoading.showError(e.toString());
                            }

                            LogUtil.debug(mnemonicStr);
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
                            'Import',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
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
        ),
      );
    }

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Stack(
      children: [
        PageView.builder(
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
            }
          },
        ),
        Positioned(
          bottom: keyboardHeight,
          left: 0,
          right: 0,
          child: Obx(() => Container(
                color: Styles.backgroundColor,
                height: 60.w,
                padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 5.w),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: suggestWords.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          LogUtil.debug(suggestWords[index]);
                          mnemonicInputs[length - 1] =
                              suggestWords[index].replaceAll(' ', '');
                          mnemonicStates[length - 1] = true;
                          length += 1;
                          mnemonicInputs.add(' ');
                          mnemonicStates.add(false);
                          inputFocus.add(FocusNode());

                          suggestWords.value = [];
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: Styles.mainColor),
                            borderRadius: BorderRadius.circular(6.w),
                          ),
                          child: Center(
                            child: Text(
                              suggestWords[index],
                              style: TextStyle(color: Styles.mainColor),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),
        ),
      ],
    );
  }
}
