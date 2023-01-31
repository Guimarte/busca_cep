import 'package:flutter/services.dart';

class ClipboardUtil {
  static Future<void> copy(String value) async {
    await Clipboard.setData(ClipboardData(text: value));
  }

  static Future<String> paste() async {
    final clipBoardDAta = await Clipboard.getData(Clipboard.kTextPlain);
    return clipBoardDAta?.text ?? "";
  }

  static Future<bool> hasData() async {
    return Clipboard.hasStrings();
  }
}