import 'package:flutter/material.dart';

class Constants {
  static Color themeColor = const Color.fromRGBO(208, 0, 0, 1);
  static Color elevationsColor = Colors.grey;
  static Color iconsColor = const Color.fromARGB(255, 75, 69, 69);
  static Color itemColor = const Color.fromARGB(255, 86, 88, 87);

  static double fontSize = 24;
  static double lineHeight = 1.5;
  static String imageURLPrefix = 'https://bnnews.iq/upload_list/thumbs/';
  static bool changeCategory = false;
  static List<dynamic> bookMarkContent = [];
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}
