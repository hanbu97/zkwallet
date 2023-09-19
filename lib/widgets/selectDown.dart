import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/config/styles.dart';

/**
 * 下拉选择组件
 */
class SelectDown extends StatefulWidget {
  // 子组件接受的参数
  SelectDown({
    required this.dataSource,
    this.hintText,
    this.defaultValue = '',
    required this.onChange,
    this.inputBg,
    this.optionBg,
  });
  final List<dynamic> dataSource; // 选择的值列表
  final Widget? hintText; // placeholder
  final String defaultValue; // 默认值
  final Function onChange; // 回调函数
  final Color? inputBg; // 选择框的背景
  final Color? optionBg; // 选择项的背景颜色
  @override
  State<SelectDown> createState() => _SelectDownState();
}

class _SelectDownState extends State<SelectDown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: widget.hintText,
          items: widget.dataSource
              .map(
                (dynamic item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Styles.titleColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          value: selectedValue ?? widget.defaultValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
              widget.onChange(value);
            });
          },
          buttonStyleData: const ButtonStyleData(
            decoration: BoxDecoration(
                // color: widget.inputBg ?? Styles.mainWhite,
                color: Colors.black),
          ),
          iconStyleData: IconStyleData(
            icon: Container(
              margin: EdgeInsets.only(right: 16.w),
              child: Image.asset(
                "assets/images/icons/arrow_bottom.png",
                width: 24.w,
                height: 24.w,
              ),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(14),
              boxShadow: null,
            ),
            offset: const Offset(0, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: 30.w,
            padding: EdgeInsets.only(left: 14.w, right: 14.w),
          ),
        ),
      ),
    );
  }
}
