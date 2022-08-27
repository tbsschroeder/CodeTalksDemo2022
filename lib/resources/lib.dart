import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:toast/toast.dart';

enum BrandColor { dark, blue, lila, aqua, green, gold, orange, red }

class ColorHelper {
  static length() {
    return BrandColor.values.length;
  }

  static Color getValue(BrandColor color) {
    switch (color) {
      case BrandColor.dark:
        return const Color(0xFF051428);
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

Text getText(String text,
        {double fontSize = 15,
        FontWeight fontWeight = FontWeight.w400,
        Color color = Colors.white,
        TextAlign textAlign = TextAlign.left}) =>
    Text(text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ));

TextField getTextField(String hint,
        {controller, textInputAction = TextInputAction.done}) =>
    TextField(
      controller: controller,
      textInputAction: textInputAction,
      decoration: InputDecoration(hintText: hint),
    );

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  return rootBundle
      .loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}

AppBar getDefaultAppBar(
        {title = 'METRO.digital Quiz',
        backgroundColor = Colors.transparent,
        elevation = 0.0,
        iconThemeColor = Colors.white}) =>
    AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      elevation: elevation,
      iconTheme: IconThemeData(
        color: iconThemeColor,
      ),
    );

void showErrorToast(final BuildContext context, final String text) {
  Toast.show(text,
      duration: Toast.lengthLong,
      backgroundColor: Theme.of(context).errorColor,
      gravity: Toast.bottom);
}

void showSuccessToast(final BuildContext context, final String text) {
  Toast.show(text,
      duration: Toast.lengthLong,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      textStyle: TextStyle(color: Theme.of(context).backgroundColor),
      gravity: Toast.bottom);
}

void dismissKeyboard(final BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
