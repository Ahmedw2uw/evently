import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode mode=ThemeMode.light;//* the initial mode 

  changeThemeMode(ThemeMode mode){
    this.mode=mode;
    notifyListeners();

  }
  @override
  void notifyListeners() {
    super.notifyListeners();
  }

}