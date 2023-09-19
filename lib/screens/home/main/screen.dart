// import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../utils/config/styles.dart';

// // import '../../res/styles_new.dart';
// // import '../../widget/bottom_bar.dart';
// // import '../chats/chats_view.dart';
// // import '../events/events_view.dart';
// // import '../menu/menu_view.dart';
// // import '../discover/discover_view.dart';
// // import 'home_logic.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var tabIndex = 0.obs;
//   final _bottomBarController = BottomBarWithSheetController(initialIndex: 0);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Scaffold(
//           backgroundColor: Styles.backgroundColor,
//           body: IndexedStack(
//             index: tabIndex.value,
//             // children: [ChatsPage(), EventsPage(), DiscoverPage(), MenuPage()],
//             children: [
//               Container(),
//               Container(),
//               Container(),
//               Container(),
//             ],
//           ),
//           bottomNavigationBar: BottomBarWithSheet(
//             controller: _bottomBarController,
//             bottomBarTheme: BottomBarTheme(
//               mainButtonPosition: MainButtonPosition.middle,
//               selectedItemIconSize: 24.w,
//               itemIconSize: 24.w,
//               selectedItemIconColor: tpStyles.mainColor,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: Offset(0, 0), // changes position of shadow0
//                   ),
//                 ],
//               ),
//               itemIconColor: Colors.grey,
//               itemTextStyle: TextStyle(
//                 color: tpStyles.mainInactive,
//                 fontSize: 10.0,
//               ),
//               selectedItemTextStyle: TextStyle(
//                 color: tpStyles.mainColor,
//                 fontSize: 10.w,
//               ),
//             ),
//             onSelectItem: (index) => {tabIndex.value = index},
//             sheetChild: Center(
//               child: Text(
//                 "Another content",
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//             ),
//             mainActionButtonTheme: MainActionButtonTheme(
//                 icon: Icon(Icons.grid_view_rounded,
//                     size: 30.w, color: Colors.white),
//                 margin:
//                     EdgeInsets.only(top: 5, bottom: 5, left: 13.w, right: 13.w),
//                 color: tpStyles.mainColor),
//             items: const [
//               BottomBarWithSheetItem(
//                 icon: Icons.message_outlined,
//               ),
//               BottomBarWithSheetItem(icon: Icons.newspaper_outlined),
//               BottomBarWithSheetItem(icon: Icons.explore_outlined),
//               BottomBarWithSheetItem(icon: Icons.person_2_outlined),
//             ],
//           ),
//         ));
//   }
// }
