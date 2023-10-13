import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/config/styles.dart';
import '../../../widgets/shadow.dart';
import 'bottom_add_bar.dart';
import 'management.dart';

class ManageWallet extends StatefulWidget {
  const ManageWallet({super.key});

  @override
  State<ManageWallet> createState() => _ManageWalletState();
}

class _ManageWalletState extends State<ManageWallet> {
  var _isReorder = false;
  var _isShown = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _isShown = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool? args = Get.arguments;

    return Stack(
      children: [
        Scaffold(
            backgroundColor: Styles.backgroundColor,
            appBar: AppBar(
              backgroundColor: Styles.backgroundColor,
              title: Text(
                'Manage Wallets',
                style: TextStyle(
                    color: Styles.mainColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.w),
              ),
              leading: args == true || args == null
                  ? BackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Styles.mainColor,
                    )
                  : null,
              iconTheme: IconThemeData(color: Styles.mainColor),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Styles.backgroundColor),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Styles.mainColor),
                      splashFactory: NoSplash.splashFactory,
                      elevation: const MaterialStatePropertyAll(0)),
                  onPressed: () => {
                    setState(() {
                      _isReorder = !_isReorder;
                    })
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: _isReorder
                              ? Icon(Icons.done)
                              : Icon(Icons.wifi_protected_setup),
                        ),
                      ),
                      Text(
                        _isReorder ? "Finish" : "Order",
                        style: GoogleFonts.titilliumWeb(
                            fontSize: 12.w, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ],
            ),
            body: Container(
                // color: backgroundGrey,
                child: WalletList(
              createWalletTrigger: () => {
                setState(() {
                  _isShown = true;
                })
              },
              groupSwithTrigger: () => {
                setState(() {
                  _isShown = false;
                })
              },
            ))),
        ShadowMaskWidget(
          isShown: _isShown,
          closeShadow: () => {
            setState(() {
              _isShown = false;
            })
          },
        ),
        WalletAddBottomBarWidget(
          isShown: _isShown,
          closeShadow: () => {
            setState(() {
              _isShown = false;
            })
          },
          entrance: true,
        )
      ],
    );
  }
}
