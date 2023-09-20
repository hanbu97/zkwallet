import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rust_bridge_template/utils/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:qr_flutter/qr_flutter.dart';

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.07; // desirable value for corners side

    Paint paint = Paint()
      ..color = Styles.mainColorDark
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      // ..color = Color.fromRGBO(238, 240, 246, 1)
      ..color = Styles.mainColorDark
      ..strokeWidth = 4;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}

class BorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.1;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ReceivePage extends StatefulWidget {
  const ReceivePage({super.key, required this.wallet});

  final String wallet;

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          backgroundColor: Styles.backgroundColor,
          elevation: 0,
          title: Text(
            "Receive",
            style: TextStyle(color: Styles.mainColor),
          ),
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Styles.mainColor,
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.w,
            ),
            Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Styles.contentBackground,
                          // border: Border.all(color: Styles.mainColor),
                          borderRadius: BorderRadius.circular(30.w)),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Styles.contentBackground,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.w),
                                        topRight: Radius.circular(15.w))),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30.w,
                                    ),
                                    Center(
                                      child: Text("Scan & Pay",
                                          style: TextStyle(
                                              color: Styles.infoGrayColor,
                                              fontSize: 15)),
                                    ),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        const Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: CustomPaint(
                                            foregroundPainter: BorderPainter(),
                                            child: ClipPath(
                                                // clipper: BorderClipper(),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.w),
                                                    child: QrImage(
                                                      data: widget.wallet,
                                                      backgroundColor: Styles
                                                          .contentBackground,
                                                      foregroundColor:
                                                          Styles.mainWhite,
                                                      // backgroundColor: ,
                                                    ))),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 30.w,
                          ),
                          Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Styles.backgroundColor,
                                    border: Border.all(
                                        color: Styles.mainColor, width: 0.6),
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(30.w))),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 20.w),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15.w,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Styles.contentBackground,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.w)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Wallet Address".tr,
                                                    style: TextStyle(
                                                        color: Styles.mainColor,
                                                        fontSize: 15.w)),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15.w,
                                                        right: 15.w,
                                                        top: 9.w),
                                                    child: Text(
                                                      widget.wallet,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13.sp),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                    flex: 1, child: SizedBox()),
                                                Expanded(
                                                    flex: 5,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextButton.icon(
                                                          style: TextButton.styleFrom(
                                                              side: BorderSide(
                                                                  color: Styles
                                                                      .mainColor,
                                                                  width: 0.5),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(8
                                                                              .w)),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10.w),
                                                              backgroundColor:
                                                                  Styles
                                                                      .contentBackground),
                                                          onPressed: () => {},
                                                          icon: const Icon(
                                                            Icons.share,
                                                            color: Colors.white,
                                                          ),
                                                          label: const Text(
                                                            "Share",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        TextButton.icon(
                                                            style: TextButton
                                                                .styleFrom(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(8
                                                                            .w)),
                                                                    side:
                                                                        BorderSide(
                                                                      width:
                                                                          0.5,
                                                                      color: Styles
                                                                          .mainColor,
                                                                    ),
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 10
                                                                            .w),
                                                                    backgroundColor:
                                                                        Styles
                                                                            .contentBackground),
                                                            onPressed: () {
                                                              Clipboard.setData(
                                                                  ClipboardData(
                                                                      text: widget
                                                                          .wallet));
                                                              Get.snackbar(
                                                                  'Receive',
                                                                  'Address copied',
                                                                  colorText: Styles
                                                                      .mainWhite);
                                                            },
                                                            icon: const Icon(
                                                              Icons.copy,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            label: const Text(
                                                              "Copy",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                      ],
                                                    )),
                                                const Expanded(
                                                    flex: 1, child: SizedBox()),
                                              ],
                                            ))
                                      ],
                                    )),
                              ))
                        ],
                      )),
                )),
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ZKTRANSFER",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Styles.mainColor),
                    )
                  ],
                ))
          ],
        ));
  }
}

class ReceivePageRoute<T> extends PageRoute<T> {
  ReceivePageRoute({
    required this.builder,
    RouteSettings? settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => null;

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: builder(context),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
