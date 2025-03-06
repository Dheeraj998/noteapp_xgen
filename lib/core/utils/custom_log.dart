import 'dart:developer';
import 'package:flutter/foundation.dart';

customPrint(String text) {
  if (kDebugMode) print(text);
}

customLog(String text) {
  if (kDebugMode) log(text);
}
