import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum BrandColor { blue, lila, aqua, green, gold, orange, red }

class ColorHelper {
  static length() {
    return BrandColor.values.length;
  }

  static Color getValue(BrandColor color) {
    switch (color) {
      case BrandColor.blue:
        return const Color(0xFF647DEB);
      case BrandColor.lila:
        return const Color(0xFFB987FA);
      case BrandColor.aqua:
        return const Color(0xFF05DCC8);
      case BrandColor.green:
        return const Color(0xFFAFDC64);
      case BrandColor.gold:
        return const Color(0xFFF0D278);
      case BrandColor.orange:
        return const Color(0xFFF58C6E);
      case BrandColor.red:
        return const Color(0xFFFF5A78);
      default:
        return const Color(0xFF051428);
    }
  }

  static Color randomColor() {
    switch (Random().nextInt(ColorHelper.length())) {
      case 0:
        return getValue(BrandColor.blue);
      case 1:
        return getValue(BrandColor.lila);
      case 2:
        return getValue(BrandColor.aqua);
      case 3:
        return getValue(BrandColor.green);
      case 4:
        return getValue(BrandColor.gold);
      case 5:
        return getValue(BrandColor.orange);
      case 6:
        return getValue(BrandColor.red);
      default:
        return getValue(BrandColor.blue);
    }
  }

  static Color getByInt(int no) {
    if (no >= ColorHelper.length()) {
      no = (no % ColorHelper.length()).toInt();
    }
    switch (no) {
      case 0:
        return getValue(BrandColor.blue);
      case 1:
        return getValue(BrandColor.lila);
      case 2:
        return getValue(BrandColor.aqua);
      case 3:
        return getValue(BrandColor.green);
      case 4:
        return getValue(BrandColor.gold);
      case 5:
        return getValue(BrandColor.orange);
      case 6:
        return getValue(BrandColor.red);
      default:
        return getValue(BrandColor.blue);
    }
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0);
}
