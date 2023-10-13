import 'package:flutter/material.dart';
import 'package:waterspay/widgets/buttons/bg_button.dart';
import '/screens/profile/pages/wallet_management.dart';
import '/screens/profile/widgets/decoration.dart';
import '/utils/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixelarticons/pixelarticons.dart';

import '../../widgets/assets/backgroud_icon.dart';
import '../../widgets/buttons/line_button.dart';
import 'pages/wallet_types.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      appBar: AppBar(
        // elevation: 0,
        backgroundColor: Styles.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(
              color: Styles.mainColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.w),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            // physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                // SizedBox(
                //   width: double.infinity,
                //   height: 200.w,
                //   child: ProfileDecoration(),
                // ),
                Styles.contentPadding(
                    child: Column(
                  children: [
                    Styles.smallSpacerV(),
                    LineButton(
                      icon: RoundIcon(
                        icon: Icons.account_balance_wallet,
                        backgroundColor: Styles.backgroundColor,
                        iconColor: Styles.mainColor,
                        size: 28.w,
                      ),
                      page: ConfigWallet(),
                      ctx: context,
                      title: "Wallet Config",
                      subtitle: "Config Wallet Types and Networks",
                    ),
                    Styles.lineSpacerV(),
                    LineButton(
                      page: ManageWallet(),
                      ctx: context,
                      title: "Wallet Management",
                      icon: RoundIcon(
                          icon: Icons.wallet_outlined,
                          backgroundColor: Styles.contentBackground,
                          size: 28.w,
                          iconColor: Styles.mainColor),
                    ),
                    Styles.lineSpacerV(),
                    LineButton(
                        icon: RoundIcon(
                          icon: Icons.contact_mail,
                          backgroundColor: Styles.contentBackground,
                          size: 28.w,
                          iconColor: Styles.mainColor,
                        ),
                        page: ProfilePage(),
                        ctx: context,
                        title: "Address Management"),
                    Styles.smallSpacerV(),
                    LineButton(
                        icon: RoundIcon(
                          icon: Icons.settings,
                          backgroundColor: Styles.contentBackground,
                          size: 28.w,
                          iconColor: Styles.mainColor,
                        ),
                        page: ProfilePage(),
                        ctx: context,
                        title: "Settings"),
                    Styles.smallSpacerV(),
                    LineButton(
                        icon: RoundIcon(
                          icon: Icons.play_lesson,
                          backgroundColor: Styles.contentBackground,
                          size: 28.w,
                          iconColor: Styles.mainColor,
                        ),
                        page: ProfilePage(),
                        ctx: context,
                        title: "Guide"),
                    Styles.lineSpacerV(),
                    LineButton(
                        icon: RoundIcon(
                          icon: Icons.info,
                          backgroundColor: Styles.contentBackground,
                          size: 28.w,
                          iconColor: Styles.mainColor,
                        ),
                        page: ProfilePage(),
                        ctx: context,
                        title: "About Us"),
                    Styles.smallSpacerV(),
                    LineButton(
                        icon: RoundIcon(
                          icon: Icons.supervised_user_circle,
                          backgroundColor: Styles.contentBackground,
                          size: 28.w,
                          iconColor: Styles.mainColor,
                        ),
                        page: ProfilePage(),
                        ctx: context,
                        title: "Invite Friends"),
                    // Styles.expandedSpacerV(),
                    SizedBox(
                      height: 300.w,
                    ),

                    Styles.smallSpacerV(),
                  ],
                ))
              ],
            ),
          ),
          Positioned(
              bottom: Styles.paramsSmallSpacerV,
              left: 0,
              right: 0,
              child: Styles.contentPadding(
                  child: BgButton(
                text: 'Logout'.tr,
              ))),
        ],
      ),
    );
  }
}
