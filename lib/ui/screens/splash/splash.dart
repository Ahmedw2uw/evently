import 'dart:async';

import 'package:evently/ui/utiliti/app_assets.dart';
import 'package:evently/ui/utiliti/app_routes.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        //! this uset to when need to pop
        context,
        AppRoutes.login,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Image.asset(AppAssets.logo, fit: BoxFit.fill));
  }
}
