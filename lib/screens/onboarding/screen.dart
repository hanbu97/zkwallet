import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge_template/utils/extension/custom_ext.dart';
import 'package:flutter_rust_bridge_template/utils/route/app_navigator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:onboarding_app/size_config.dart';
import '../../utils/config/styles.dart';
import 'contents.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50.w),
        ),
        color: _currentPage == index ? Styles.mainColor : Styles.mainInactive,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 4.w,
      curve: Curves.easeIn,
      width: _currentPage == index ? 41.w : 19.w,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _controller,
              onPageChanged: (value) => setState(() => _currentPage = value),
              itemCount: contents.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    SizedBox(
                      height: 131.w,
                    ),
                    contents[i].image.toImage..width = 322.w,
                    SizedBox(
                      height: 122.w,
                    ),
                    Text(contents[i].title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.titilliumWeb(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                            color: Styles.mainWhite)),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 290.w,
                      child: Text(
                        contents[i].desc,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rubik(
                            fontSize: 14.sp,
                            color: Styles.mainWhite.withOpacity(0.8)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (int index) => _buildDots(
                      index: index,
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _currentPage + 1 == contents.length
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                            ),
                            child: SizedBox(
                              width: 200.w,
                              height: 48.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: ElevatedButton(
                                  onPressed: () {
                                    AppNavigator.newWallet();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Styles.mainColor,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Get Start",
                                      style: GoogleFonts.rubik(
                                          fontSize: 18.sp, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _controller.jumpToPage(3);
                                  },
                                  style: TextButton.styleFrom(
                                    elevation: 0,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  child: Text(
                                    "SKIP",
                                    style: TextStyle(
                                        color:
                                            Styles.mainColor.withOpacity(0.7)),
                                  ),
                                ),
                                SizedBox(
                                  width: 48.w,
                                  height: 45.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeIn,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Styles.mainColor,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: const Center(
                                          child: Icon(
                                        Icons.arrow_forward_outlined,
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
      // SafeArea(
      //   child:
      // ),
    );
  }
}
