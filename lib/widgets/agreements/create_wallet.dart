import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge_template/utils/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateWalletAgreementWidget extends StatefulWidget {
  RxBool initAgree;

  CreateWalletAgreementWidget({super.key, required this.initAgree});

  @override
  State<CreateWalletAgreementWidget> createState() =>
      _CreateWalletAgreementWidgetState();
}

class _CreateWalletAgreementWidgetState
    extends State<CreateWalletAgreementWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() => Checkbox(
              checkColor: Colors.black,
              focusColor: Colors.black,
              fillColor: widget.initAgree.value
                  ? MaterialStateProperty.all(Styles.mainColor)
                  : MaterialStateProperty.all(Styles.infoGrayColor),
              value: widget.initAgree.value,
              onChanged: (value) => {
                widget.initAgree.value = !widget.initAgree.value,
              },
            )),
        Expanded(
          child: RichText(
            softWrap: true,
            text: TextSpan(
              text: 'Accept ',
              style: GoogleFonts.rubik(
                color: Styles.infoGrayColor,
                fontSize: 14.w,
              ),
              children: [
                TextSpan(
                    text: 'Term of Service',
                    style: TextStyle(
                        color: Styles.mainColor,
                        fontSize: 14.w,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
