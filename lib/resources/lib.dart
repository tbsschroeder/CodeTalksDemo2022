import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class ColorHelper {
  static length() {
    return 7;
  }

  static Color getByInt(int no) {
    if (no >= ColorHelper.length()) {
      no = (no % ColorHelper.length()).toInt();
    }
    switch (no) {
      case 0:
        return const Color(0xFF647DEB);
      case 1:
        return const Color(0xFFB987FA);
      case 2:
        return const Color(0xFF05DCC8);
      case 3:
        return const Color(0xFFAFDC64);
      case 4:
        return const Color(0xFFF0D278);
      case 5:
        return const Color(0xFFF58C6E);
      case 6:
        return const Color(0xFFFF5A78);
      default:
        return const Color(0xFF051428);
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

String getMadeWithLove() {
  var platform = kIsWeb ? 'the web' : Platform.operatingSystem;
  return 'Made with ☕️ for $platform in Düsseldorf';
}
