import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  //! ChangeNotifier=>  this to can create obhect from ChangeNotifierProvider
  String curentLanguage = "en";

  void changeLanguage(String language) {
    curentLanguage = language;
    notifyListeners();
  }

  //! the same in setState
  // @override
  // void notifyListeners() {
  //   super.notifyListeners();
  //   //! its tel to notify the lisners ans this is contain of the context  and rebild
  //   //* this is setState of all proogect
  // }
}
