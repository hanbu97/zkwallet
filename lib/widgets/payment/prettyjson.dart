import 'dart:convert';
import 'package:flutter/material.dart';

class PrettyJsonText extends StatelessWidget {
  // final Map<String, Object?> data;
  final Object? data;

  PrettyJsonText({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text(
        _prettyPrint(data),
        style: TextStyle(fontFamily: 'Courier', fontSize: 16), // 使用等宽字体，使得格式更整齐
      ),
    );
  }

  // String _prettyPrint(Map<String, Object?> data) {
  String _prettyPrint(Object? data) {
    var encoder = JsonEncoder.withIndent('  '); // 缩进为两个空格
    return encoder.convert(data);
  }
}

class PrettyListText extends StatelessWidget {
  final List<dynamic> data;

  PrettyListText({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text(
        _prettyPrint(data),
        style: TextStyle(fontFamily: 'Courier', fontSize: 16), // 使用等宽字体，使得格式更整齐
      ),
    );
  }

  String _prettyPrint(List<dynamic> data) {
    var encoder = JsonEncoder.withIndent('  '); // 缩进为两个空格
    return encoder.convert(data);
  }
}
