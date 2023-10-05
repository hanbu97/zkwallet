import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '/utils/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LineButton extends StatelessWidget {
  final String title;
  final BuildContext ctx;
  final Widget page;
  final String? subtitle;

  final Widget? icon;
  const LineButton(
      {required this.page,
      required this.ctx,
      required this.title,
      this.icon,
      this.subtitle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          ctx,
          MaterialPageRoute(builder: (context) => page),
        )
      },
      child: Container(
        color: Styles.buttonBackground,
        padding: EdgeInsets.symmetric(vertical: 5.w),
        child: Row(
          children: [
            icon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: icon ?? SizedBox(),
                  )
                : SizedBox(),
            subtitle == null
                ? Padding(
                    padding: EdgeInsets.all(15.w),
                    child: Text(
                      title,
                      style: Styles.contentWhite,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Styles.contentWhite,
                        ),
                        Text(
                          subtitle ?? "",
                          style: Styles.contentmainDarkSmall,
                        ),
                      ],
                    )),
            const Expanded(child: SizedBox()),
            Padding(
                padding: EdgeInsets.all(15),
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }
}
