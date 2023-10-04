import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rust_bridge_template/utils/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/route/app_navigator.dart';

class WalletAddBottomBarWidget extends StatefulWidget {
  final bool isShown;
  final Function? closeShadow;
  final bool entrance;

  const WalletAddBottomBarWidget(
      {Key? key,
      required this.isShown,
      this.closeShadow,
      this.entrance = false})
      : super(key: key);

  @override
  State<WalletAddBottomBarWidget> createState() =>
      _WalletAddBottomBarWidgetState();
}

class _WalletAddBottomBarWidgetState extends State<WalletAddBottomBarWidget> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isShown
        ? AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                // height: 300,
                decoration: BoxDecoration(
                  color: Styles.mainWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                      ),
                      width: double.infinity,
                      child: FractionallySizedBox(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () => {
                                    if (widget.entrance)
                                      {
                                        setState(() {
                                          widget.closeShadow!();
                                        }),
                                        AppNavigator.newWallet()
                                      }
                                    else
                                      {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                "/createWallet",
                                                arguments: false),
                                      }
                                  },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.w),
                                child: Center(
                                  child: Text(
                                    'Create Wallet',
                                    style: TextStyle(
                                      color: Styles.mainColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: FractionallySizedBox(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () => {
                                    if (widget.entrance)
                                      {
                                        Navigator.of(context).pushNamed(
                                            "/importWallet",
                                            arguments: true),
                                        setState(() {
                                          widget.closeShadow!();
                                        }),
                                      }
                                    else
                                      {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                "/importWallet",
                                                arguments: false),
                                      }
                                  },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.w),
                                child: Center(
                                  child: Text(
                                    'Import Wallet',
                                    style: TextStyle(
                                      color: Styles.mainColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: FractionallySizedBox(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () => {
                                    setState(() {
                                      widget.closeShadow!();
                                    }),
                                  },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).padding.bottom,
                    )
                  ],
                )),
          )
        : const SizedBox();
  }
}
