import 'package:evently/ui/screens/add_event/add_event.dart';
import 'package:evently/ui/screens/home/home.dart';
import 'package:evently/ui/screens/login/login.dart';
import 'package:evently/ui/screens/regester/regester.dart';
import 'package:flutter/material.dart';

//! this class contain of all routes in app
abstract final class AppRoutes {
  static Route get login {
    //* we use get like object
    return MaterialPageRoute(builder: (_) => Login());
  } //* this to navigate to the login page

  static Route get home {
    return MaterialPageRoute(builder: (_) => Home());
  } //* this to navigate to the home page

  static Route get regester {
    return MaterialPageRoute(builder: (_) => Regester());
  } //* this to navigate to the regester page

  static Route get addEvent {
    return MaterialPageRoute(builder: (_) => AddEvent());
  } //* this to navigate to the regester page
  
}
