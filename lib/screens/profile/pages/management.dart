import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rust_bridge_template/utils/config/images.dart';
import 'package:flutter_rust_bridge_template/utils/config/styles.dart';
import 'package:flutter_rust_bridge_template/utils/extension/custom_ext.dart';
import 'package:flutter_rust_bridge_template/utils/state/data_sp.dart';
import 'package:flutter_rust_bridge_template/widgets/assets/coin_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/wallet/wallets_group_read.dart';
import '../../../utils/string/string_utils.dart';

class WalletList extends StatefulWidget {
  final bool isExpanded;
  final Function? createWalletTrigger;
  final Function? groupSwithTrigger;

  WalletList({
    Key? key,
    this.isExpanded = false,
    this.createWalletTrigger,
    this.groupSwithTrigger,
  }) : super(key: key);

  @override
  State<WalletList> createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  var _groupSelectedIndex = 0;

  var _accountSelectedIndex = 0;
  var _showGroup = false;

  List<WalletGroupRead> _groupList = [];

  void _refreshGroupList() async {
    setState(() {
      _groupList = DataSp.walletGroupRead;
    });
  }

  void _initSelectedWalletGroupId() {
    _groupSelectedIndex = DataSp.selectedWalletGroupId;
  }

  @override
  void initState() {
    super.initState();

    _initSelectedWalletGroupId();
  }

  @override
  Widget build(BuildContext context) {
    _initSelectedWalletGroupId();
    _refreshGroupList();

    return Flex(
      direction: Axis.vertical,
      children: [
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        disabledBackgroundColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        elevation: 0),
                    onPressed: () => {
                      setState(() {
                        _showGroup = !_showGroup;
                        widget.groupSwithTrigger!();
                      })
                    },
                    child: Icon(
                      Icons.menu,
                      color: Styles.mainColor,
                    ),
                  ),
                )),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    StringUtils.truncateString(DataSp.selectedWalletGroupName),
                    style: GoogleFonts.rubik(
                        fontSize: 12.w,
                        color: Styles.infoGrayColor,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
            )
          ],
        ),
        Expanded(
            flex: 1,
            child: SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: ListView(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 10.w),
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Center(
                                      child: Container(
                                          width: 36.w,
                                          height: 36.w,
                                          padding: EdgeInsets.all(4.w),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Styles.mainColor,
                                                width: 1.w),
                                            borderRadius:
                                                BorderRadius.circular(18.w),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Styles.mainColor,
                                          )),
                                    ),
                                  ],
                                )),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: _groupList.length,
                              padding: EdgeInsets.only(
                                  bottom: widget.isExpanded ? 100 : 30),
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                      onTap: () async {
                                        _groupSelectedIndex = index;
                                        // await appState
                                        //     .setSelectedWalletGroupId(index)
                                        //     .then((value) => {
                                        //           setState(() {
                                        //             _groupSelectedIndex = index;
                                        //           })
                                        //         });
                                      },
                                      onLongPress: () async {
                                        // pop up a dialog to confirm deletion
                                        // if _confirmDismiss return true then delete, else do nothing

                                        //   await confirmDelete(
                                        //           _groupList[index].name, context)
                                        //       .then((todelete) async {
                                        //     if (todelete) {
                                        //       await appState.deleteWalletGroup(
                                        //           _groupList[index].name);

                                        //       _refreshGroupList();

                                        //       if (_groupList.isEmpty) {
                                        //         await appState
                                        //             .setSelectedWalletGroupName("");
                                        //       }

                                        //       setState(() {
                                        //         if (_groupList.isEmpty) {
                                        //           Navigator.of(context)
                                        //               .pushReplacementNamed("/home");
                                        //         }

                                        //         // if selected is to delete, select first
                                        //         if (index ==
                                        //             appState.selectedWalletGroupId) {
                                        //           appState
                                        //               .setSelectedWalletGroupId(0);
                                        //         }
                                        //       });
                                        //     }
                                        //   });
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.w),
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Center(
                                                child: Container(
                                                    width: 36.w,
                                                    height: 36.w,
                                                    padding:
                                                        EdgeInsets.all(4.w),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Styles.mainColor,
                                                          width: 1.w),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.w),
                                                    ),
                                                    child: ImageRes
                                                        .zkLogo.toImage),
                                              ),
                                              _showGroup
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.w),
                                                      child: Text(
                                                        StringUtils
                                                            .truncateString(
                                                                _groupList[
                                                                        index]
                                                                    .name,
                                                                maxLength: 18),
                                                        style: TextStyle(
                                                            color: Styles
                                                                .infoGrayColor,
                                                            fontSize: 12.w,
                                                            decoration:
                                                                TextDecoration
                                                                    .none),
                                                      ),
                                                    )
                                                  : const SizedBox()
                                            ],
                                          ))),
                            )
                          ],
                        )),
                    Expanded(
                        flex: _showGroup ? 1 : 5,
                        child: ListView(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Card(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Styles.backgroundColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.w)),
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.w)),
                                            side: BorderSide(
                                              width: 1.w,
                                              color: Styles.mainColor,
                                            ),
                                            backgroundColor:
                                                Styles.backgroundColor,
                                            shadowColor: Colors.transparent,
                                            elevation: 0),
                                        onPressed: () => {
                                          setState(() {
                                            widget.createWalletTrigger!();
                                          })
                                        },
                                        child: Center(
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                fontSize: 40.w,
                                                color: Styles.mainColor),
                                          ),
                                        ),
                                      ))),
                            ),
                            ListView.builder(
                              itemCount: 25,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                  bottom: widget.isExpanded ? 100 : 30),

                              itemBuilder: (BuildContext context, int index) =>
                                  Column(
                                children: [
                                  GestureDetector(
                                      onTap: () => {
                                            setState(() {
                                              _accountSelectedIndex = index;
                                            })
                                          },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Card(
                                            child: Container(
                                          decoration: BoxDecoration(
                                            color: Styles.contentBackground,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(4.w),
                                            ),
                                            border: Border.all(
                                              color:
                                                  _accountSelectedIndex == index
                                                      ? Styles.mainColor
                                                      : Styles.backgroundColor,
                                              width: 1.w,
                                            ),
                                          ),
                                          padding: EdgeInsets.all(10.w),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Fil-1',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  'f1jkzcn2xstealyngllhdjmeygrp6b5amvzhvklbi',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(child: SizedBox()),
                                                    Text(
                                                      '5.21 FIL',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                )
                                              ]),
                                        )),
                                      )),
                                ],
                              ),
                              // )
                            )
                          ],
                        ))
                  ],
                ))),
      ],
    );
  }
}
