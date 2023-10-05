import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/utils/config/styles.dart';
import '/utils/route/app_navigator.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../models/wallet/wallets.dart';
import '../../utils/encryption/general.dart';
import '../../utils/storage/general.dart';

class VerifyPassword extends StatefulWidget {
  final String name;
  final String address;
  final bool isOffline;
  final Tuple2<Map<String, Object?>, String> msg;
  final BuildContext context;
  final Map<String, Object>? addt;

  const VerifyPassword(
      {super.key,
      required this.name,
      required this.address,
      required this.msg,
      required this.isOffline,
      required this.context,
      this.addt});

  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  var _isPasswordVisible = false;
  String _pasword = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(234, 240, 254, 1),
      content: Form(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Please enter your wallet password',
            hintStyle: const TextStyle(color: Colors.grey),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Styles.mainColor),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                // 使用一个变量来保存密码是否明文显示的状态
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.black54,
              ),
              onPressed: () {
                // 点击图标时切换密码是否明文显示的状态
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          // 使用一个变量来保存密码是否明文显示的状态

          obscureText: !_isPasswordVisible,
          style: const TextStyle(color: Colors.black),
          onChanged: (value) {
            setState(() {
              _pasword = value;
            });
          },
        ),
      ),
      title: const Text(
        'Verify Password',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        ButtonBar(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const VerticalDivider(color: Colors.grey),
            TextButton(
              onPressed: () async {
                try {
                  // final appState =
                  //     Provider.of<AppState>(context, listen: false);

                  // final Wallet wallet = await dbGetGroupWallet(
                  //     HiveDBName.walletGroup,
                  //     appState.selectedWalletGroupName!);

                  // String secret = Encryption.decrypt(
                  //     wallet.secretKey, _pasword, EncryptionMethod.fernet);

                  // final signed = await api.signString(
                  //     msg: widget.msg.item2, privateKey: secret);

                  // drop secret
                  // secret = "";

                  // 1. insert to msg local db
                  // 2. waiting for msg result
                  // final msgcid = await pushMessage(
                  //     context, widget.msg.item1, signed[1], signed[0],
                  //     addt: widget.addt);

                  var pageIndex = 0;
                  var manageIndex = 0;
                  if (widget.name.contains("msig")) {
                    pageIndex = 1;
                  } else if (widget.name.contains('single_send')) {
                    pageIndex = 3;
                  } else if (widget.name.contains("node_change_owner")) {
                    pageIndex = 1;
                    manageIndex = 1;
                  }

                  AppNavigator.homepage();

                  // Get.offAll(HomePage(
                  //   selectedIndex: pageIndex,
                  //   manageSelectedIndex: manageIndex,
                  // ));
                } catch (e) {
                  if (e.toString().contains("Invalid token")) {
                    EasyLoading.showError("Password Error!");
                  }
                }
              },
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        // TextButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Text('Cancel'),
        // ),
        // TextButton(
        //   onPressed: () {
        //     // TODO: 确认操作
        //   },
        //   child: Text('Confirm'),
        // ),
      ],
    );
    ;
  }
}
