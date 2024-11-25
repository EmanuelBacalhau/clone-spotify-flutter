import 'package:flutter/material.dart';

extension DarkMoOde on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
