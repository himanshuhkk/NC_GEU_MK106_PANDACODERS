import 'package:flutter/material.dart';

class Config extends ChangeNotifier {
  bool isLightMode = true;

  void toggleTheme() {
    this.isLightMode = !this.isLightMode;
    notifyListeners();
  }
}